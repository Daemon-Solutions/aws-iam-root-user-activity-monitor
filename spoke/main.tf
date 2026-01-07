resource "aws_cloudwatch_event_target" "root_alarm_target" {
  rule      = aws_cloudwatch_event_rule.root_alarm_rule.name
  target_id = "SendRootAlarmToHubEventBus"
  arn       = "arn:aws:events:${data.aws_region.current.id}:${var.hub_account}:event-bus/${var.hub_event_bus_name}"
  role_arn  = aws_iam_role.event_delivery_role.arn
}

resource "aws_cloudwatch_event_target" "root_activity_target" {
  rule      = aws_cloudwatch_event_rule.root_activity_monitor_rule.name
  target_id = "MemberAccountEvent"
  arn       = "arn:aws:events:${data.aws_region.current.id}:${var.hub_account}:event-bus/${var.hub_event_bus_name}"
  role_arn  = aws_iam_role.event_delivery_role.arn
}
