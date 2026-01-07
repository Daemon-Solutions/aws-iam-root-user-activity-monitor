resource "aws_sns_topic" "root_activity_sns_topic" {
  name         = var.sns_root_activity_topic_name
  display_name = var.sns_root_activity_topic_display_name
  policy       = data.aws_iam_policy_document.root_activity_sns_policy.json
}

data "aws_iam_policy_document" "root_activity_sns_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    actions = [
      "SNS:Publish",
    ]
    resources = [
      "arn:aws:sns:eu-west-1:${data.aws_caller_identity.current.account_id}:${var.sns_root_activity_topic_name}"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}



resource "aws_sns_topic" "root_login_alarm_sns_topic" {
  name         = var.sns_root_login_alarm_topic_name
  display_name = var.sns_root_login_alarm_topic_display_name
  policy       = data.aws_iam_policy_document.root_login_alarm_sns_policy.json
}


data "aws_iam_policy_document" "root_login_alarm_sns_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    actions = [
      "SNS:Publish",
    ]
    resources = [
      "arn:aws:sns:eu-west-1:${data.aws_caller_identity.current.account_id}:${var.sns_root_login_alarm_topic_name}"
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

  }
}




resource "aws_sns_topic" "root_activity_email_sns_topic" {
  count        = var.enable_root_activity_email_alert || var.enable_root_activity_email_alert ? 1 : 0
  name         = var.root_activity_email_config.sns_topic_name
  display_name = var.root_activity_email_config.sns_topic_display_name
  policy       = data.aws_iam_policy_document.root_activity_email_sns_policy[0].json
}

data "aws_iam_policy_document" "root_activity_email_sns_policy" {
  count = var.enable_root_activity_email_alert || var.enable_root_activity_email_alert ? 1 : 0
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }


    actions = [
      "SNS:Publish",
    ]
    resources = [
      "arn:aws:sns:eu-west-1:${data.aws_caller_identity.current.account_id}:${var.root_activity_email_config.sns_topic_name}"
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

  }
}



resource "aws_sns_topic_subscription" "root_activity_email_sns_topic_subscription" {
  count     = var.enable_root_activity_email_alert || var.enable_root_activity_email_alert ? 1 : 0
  endpoint  = var.root_activity_email_config.email_address
  protocol  = "email-json"
  topic_arn = aws_sns_topic.root_activity_email_sns_topic[0].arn
}
