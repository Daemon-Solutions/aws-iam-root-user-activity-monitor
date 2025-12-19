

output "root_alarm_rule" {
  value = aws_cloudwatch_event_rule.root_alarm_rule
}
output "root_activity_monitor_rule" {
  value = aws_cloudwatch_event_rule.root_activity_monitor_rule
}