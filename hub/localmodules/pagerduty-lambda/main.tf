module "root_activity_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 8.0"

  function_name = var.lambda_name
  description   = "Handles root account activity events"
  handler       = "main.handler"
  runtime       = "python3.13"

  source_path = "${path.module}/lambda"

  publish = true

  environment_variables = {
    PAGERDUTY_ROUTING_KEY = var.pagerduty_routing_key
  }

   allowed_triggers = {
    AllowExecutionFromSNS = {
      principal  = "sns.amazonaws.com"
      source_arn = var.sns_invoker_arn
    }
  }
}


resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = var.sns_invoker_arn
  protocol  = "lambda"
  endpoint  = module.root_activity_lambda.lambda_function_arn
}

