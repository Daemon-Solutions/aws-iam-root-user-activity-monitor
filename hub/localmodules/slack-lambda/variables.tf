variable "slack_webhook_url" {
  description = "The Slack webhook URL for sending notifications"
  type = string
}

variable "sns_invoker_arn" {
  description = "ARN of the SNS topic that invokes the lambda function"
  type = string
}


variable "lambda_name" {
    description = "Name of the Slack Lambda function"
    type = string
}