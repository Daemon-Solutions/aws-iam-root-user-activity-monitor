variable "lambda_name" {
  description = "Name of the Lambda function"
  type        = string
}


variable "sns_invoker_arn" {
  description = "ARN of the SNS topic that invokes the lambda function"
  type = string
}


variable "sns_email_topic_arn" {
  description = "ARN of the SNS topic used for email notifications"
  type = string
}
