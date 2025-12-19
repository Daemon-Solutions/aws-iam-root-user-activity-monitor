module "root_activity" {
  source = "../localmodules/root-activity"
  cloudtrail_log_group_name = var.cloudtrail_log_group_name
  alarm_evaluation_periods  = var.alarm_evaluation_periods
}

resource "aws_cloudwatch_event_target" "root_alarm_target" {
  rule      = module.root_activity.root_alarm_rule.name
  target_id = "SendRootAlarmToHubEventBus"
  arn       = "arn:aws:events:${data.aws_region.current.name}:${var.hub_account}:event-bus/${var.hub_event_bus_name}"
  role_arn  = aws_iam_role.event_delivery_role.arn
}

resource "aws_cloudwatch_event_target" "root_activity_target" {
  rule      =  module.root_activity.root_activity_monitor_rule.name
  target_id = "MemberAccountEvent"
  arn       = "arn:aws:events:${data.aws_region.current.name}:${var.hub_account}:event-bus/${var.hub_event_bus_name}"
  role_arn  = aws_iam_role.event_delivery_role.arn
}


