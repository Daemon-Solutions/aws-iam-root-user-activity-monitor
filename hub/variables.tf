
variable "sns_root_activity_topic_name" {
  description = "SNS topic name for root activity notifications"
  type        = string
  default     = "aws-iam-root-user-activity-monitor"
}

variable "sns_root_activity_topic_display_name" {
  description = "Display name for the SNS root activity topic"
  type        = string
  default     = "AWS IAM Root User Activity Monitor"
}

variable "sns_root_login_alarm_topic_name" {
  description = "SNS topic name for root login alarm notifications"
  type        = string
  default     = "aws-iam-root-user-login-alarm-monitor"
}

variable "sns_root_login_alarm_topic_display_name" {
  description = "Display name for the SNS root login alarm topic"
  type        = string
  default     = "AWS IAM Root User Login Alarm Monitor"
}


variable "hub_event_bus_name" {
  type        = string
  description = "Name of the EventBridge event bus in the account"
  default     = "hub-root-activity"
}


variable "cloudtrail_log_group_name" {
  type        = string
  description = "Cloudtrail cloudwatch log group name"
}

variable "alarm_evaluation_periods" {
  type        = number
  description = "The period over which the root account activity metric is evaluated, in seconds"
  default     = 300
}


## Root login alerts
variable "enable_root_login_slack_alert" {
  type        = bool
  default     = false
  description = "Enable Slack alerts for root login events."
}

variable "enable_root_login_pagerduty_alert" {
  type        = bool
  default     = false
  description = "Enable PagerDuty alerts for root login events."
}

variable "enable_root_login_email_alert" {
  type        = bool
  default     = false
  description = "Enable email alerts for root login events."
}

variable "root_login_slack_lambda_name" {
  type        = string
  default     = "root-login-slack-alarm-handler"
  description = "Lambda function name for root login Slack alert."

}



variable "root_login_pagerduty_lambda_name" {
  type        = string
  default     = "root-login-pagerduty-alarm-handler"
  description = "Lambda function name for root login PagerDuty alert."
}



variable "root_login_email_lambda_name" {
  type        = string
  default     = "root-login-email-alarm-handler"
  description = "Lambda function name for root login email alert."
}

## Root activity alerts
variable "enable_root_activity_slack_alert" {
  type        = bool
  default     = false
  description = "Enable Slack alerts for root activity events."
}


variable "enable_root_activity_email_alert" {
  type        = bool
  default     = false
  description = "Enable email alerts for root activity events."
}

variable "root_activity_slack_lambda_name" {
  type        = string
  default     = "root-activity-slack-alarm-handler"
  description = "Lambda function name for root activity Slack alert."
}


variable "root_activity_email_lambda_name" {
  type        = string
  default     = "root-activity-email-alarm-handler"
  description = "Lambda function name for root activity email alert."

}

variable "slack_webhook_url" {
  type        = string
  default     = null
  description = "Slack webhook URL used by Slack alert lambdas. Required if Slack alerts are enabled."
}

variable "pagerduty_routing_key" {
  type        = string
  default     = null
  description = "PagerDuty routing key used by PagerDuty alert lambdas. Required if PagerDuty alerts are enabled."
}


variable "root_activity_email_config" {
  description = "Email configuration for root activity notifications"
  type = object({
    sns_topic_name         = optional(string, "aws-iam-root-user-activity-email-monitor")
    sns_topic_display_name = optional(string, "AWS IAM Root User Activity Monitor")
    email_address          = string
  })
  default = null
}
