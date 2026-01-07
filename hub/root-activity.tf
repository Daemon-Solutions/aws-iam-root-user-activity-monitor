### CloudWatch Logs Insights Query Definition
resource "aws_cloudwatch_query_definition" "root_account_logins_query" {
  name            = "CIS-Alarms/CIS-Root Activity"
  log_group_names = [var.cloudtrail_log_group_name]

  query_string = <<QUERY
fields @timestamp, @message
| sort @timestamp desc
| filter userIdentity.type == 'Root' and eventType != 'AwsServiceEvent'
QUERY
}



### CloudWatch Alarm for Root User Activity
resource "aws_cloudwatch_log_metric_filter" "root_account_logins" {
  name           = "RootAccountLoginsFilter"
  log_group_name = var.cloudtrail_log_group_name
  pattern        = <<PATTERN
{
  $.userIdentity.type = "Root" &&
  $.userIdentity.invokedBy NOT EXISTS &&
  $.eventType != "AwsServiceEvent"
}
PATTERN

  metric_transformation {
    name      = "RootUserEventCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "root_account_logins_alarm" {
  alarm_name          = "CIS-Root Activity"
  alarm_description   = "Alarm if a 'root' user uses the account"
  namespace           = "CloudTrailMetrics"
  metric_name         = aws_cloudwatch_log_metric_filter.root_account_logins.metric_transformation[0].name
  statistic           = "Sum"
  period              = var.alarm_evaluation_periods 
  evaluation_periods  = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"

  depends_on = [
    aws_cloudwatch_log_metric_filter.root_account_logins
  ]
}

resource "aws_cloudwatch_event_rule" "root_alarm_rule" {
  name        = "RootAlarmRule"
  description = "Forwards root user alarm state changes to the hub event bus"
  event_bus_name = aws_cloudwatch_event_bus.hub_root_activity_eventbus.name
  event_pattern = <<EOF
{
  "source": ["aws.cloudwatch"],
  "detail-type": ["CloudWatch Alarm State Change"],
  "detail": {
    "alarmName": ["CIS-Root Activity"],
    "state": {
      "value": ["ALARM"]
    }
  }
}
EOF
}



### CloudWatch Event Rule for Root User Activity Monitoring
resource "aws_cloudwatch_event_rule" "root_activity_monitor_rule" {
  name        = "RootActivityMonitorRule"
  description = "Events rule for monitoring root API activity"
  event_bus_name = aws_cloudwatch_event_bus.hub_root_activity_eventbus.name
  event_pattern = jsonencode({
    "detail-type" = [
      "AWS API Call via CloudTrail",
      "AWS Console Sign In via CloudTrail"
    ]
    "detail" = {
      "userIdentity" = {
        "type" = ["Root"]
      }
    }
  })
  state = "ENABLED"
}
