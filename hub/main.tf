// Event Bus Resources
resource "aws_cloudwatch_event_bus" "hub_root_activity_eventbus" {
  name = "hub-root-activity"
}

resource "aws_cloudwatch_event_permission" "hub_root_activity_eventbus_OrgAccess" {
  event_bus_name = aws_cloudwatch_event_bus.hub_root_activity_eventbus.name
  principal      = "*"
  statement_id   = "OrganizationAccess"

  condition {
    key   = "aws:PrincipalOrgID"
    type  = "StringEquals"
    value = data.aws_organizations_organization.myorg.id
  }
}


module "root_activity" {
  source = "../localmodules/root-activity"
  cloudtrail_log_group_name = var.cloudtrail_log_group_name
  alarm_evaluation_periods  = var.alarm_evaluation_periods
  event_bus_name = aws_cloudwatch_event_bus.hub_root_activity_eventbus.name
}


resource "aws_cloudwatch_event_target" "root_activity_event_target" {
  event_bus_name = aws_cloudwatch_event_bus.hub_root_activity_eventbus.name
  rule           = module.root_activity.root_activity_monitor_rule.name
  arn            = aws_sns_topic.root_activity_sns_topic.arn

}

resource "aws_cloudwatch_event_target" "root_alarm_event_target" {
  event_bus_name = aws_cloudwatch_event_bus.hub_root_activity_eventbus.name
  rule           = module.root_activity.root_alarm_rule.name
  arn            = aws_sns_topic.root_login_alarm_sns_topic.arn
}





## ROOT LOGIN ALERTS


module "root_login_slack_alert" {
  count = var.enable_root_login_slack_alert ? 1 : 0
  source = "./localmodules/slack-lambda"
  slack_webhook_url = var.slack_webhook_url
  sns_invoker_arn = aws_sns_topic.root_login_alarm_sns_topic.arn
  lambda_name = var.root_login_slack_lambda_name

}


module "root_login_pagerduty_alarm_alert" {
  count = var.enable_root_login_pagerduty_alert ? 1 : 0
  source = "./localmodules/pagerduty-lambda"
  pagerduty_routing_key = var.pagerduty_routing_key
  sns_invoker_arn = aws_sns_topic.root_login_alarm_sns_topic.arn
  lambda_name = var.root_login_pagerduty_lambda_name
}

module "root_login_email_alarm_alert" {
  count = var.enable_root_login_email_alert ? 1 : 0
  source = "./localmodules/email-lambda"
  sns_email_topic_arn = aws_sns_topic.root_activity_email_sns_topic[0].arn
  sns_invoker_arn = aws_sns_topic.root_activity_sns_topic.arn
  lambda_name = var.root_login_email_lambda_name
}

## ROOT ACTIVITY ALERTS

module "root_activity_email_alarm_alert" {
  count = var.enable_root_activity_email_alert ? 1 : 0
  source = "./localmodules/email-lambda"
  sns_email_topic_arn = aws_sns_topic.root_activity_email_sns_topic[0].arn
  sns_invoker_arn = aws_sns_topic.root_activity_sns_topic.arn
  lambda_name = var.root_activity_email_lambda_name
}

module "root_activity_slack_alert" {
  count = var.enable_root_activity_slack_alert ? 1 : 0
  source = "./localmodules/slack-lambda"
  lambda_name = var.root_activity_slack_lambda_name
  slack_webhook_url = var.slack_webhook_url
  sns_invoker_arn = aws_sns_topic.root_activity_sns_topic.arn
}
