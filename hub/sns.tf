resource "aws_sns_topic" "root_activity_sns_topic" {
  name              = var.sns_root_activity_topic_name
  display_name      = var.sns_root_activity_topic_display_name
}


resource "aws_sns_topic" "root_login_alarm_sns_topic" {
  name              = var.sns_root_login_alarm_topic_name
  display_name      = var.sns_root_login_alarm_topic_display_name
}


resource "aws_sns_topic" "root_activity_email_sns_topic" {
  count = var.enable_root_activity_email_alert || var.enable_root_activity_email_alert ? 1 : 0
  name              = var.root_activity_email_config.sns_topic_name
  display_name      = var.root_activity_email_config.sns_topic_display_name
}


resource "aws_sns_topic_subscription" "root_activity_email_sns_topic_subscription" {
  count = var.enable_root_activity_email_alert || var.enable_root_activity_email_alert ? 1 : 0
  endpoint  = var.root_activity_email_config.email_address
  protocol  = "email-json"
  topic_arn = aws_sns_topic.root_activity_email_sns_topic[0].arn
}

