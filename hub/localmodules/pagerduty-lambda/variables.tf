variable "pagerduty_routing_key" {
  description = "The PagerDuty routing key for sending alerts"
  type = string
}


variable "sns_invoker_arn" {
  description = "ARN of the SNS topic that invokes the lambda function"
  type = string
}

variable "lambda_name" {
    description = "Name of the PagerDuty Lambda function"
    type = string
}