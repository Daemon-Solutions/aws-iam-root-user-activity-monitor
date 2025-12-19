output "orgid" {
  value = data.aws_organizations_organization.myorg.id
}

output "root_activity_sns_topic_arn" {
  value = aws_sns_topic.root_activity_sns_topic.arn
}

output "root_alarm_sns_topic_arn" {
  value = aws_sns_topic.root_login_alarm_sns_topic.arn
}
