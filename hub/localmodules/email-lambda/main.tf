
resource "aws_iam_role_policy" "lambda_root_api_monitor_policy" {
  name   = "LambdaRootAPIMonitorPolicy"
  role   = aws_iam_role.lambda_root_api_monitor_role.id
  policy = file("${path.module}/iam/lambda-policy.json")
}

resource "aws_iam_role" "lambda_root_api_monitor_role" {
  name               = "LambdaRootAPIMonitorRole"
  assume_role_policy = file("${path.module}/iam/lambda-assume-policy.json")
}


data "archive_file" "RootActivityLambda" {
  type        = "zip"
  source_file = "${path.module}/lambda/RootActivityLambda.py"
  output_path = "${path.module}/outputs/RootActivityLambda.zip"
}

resource "aws_lambda_function" "root_activity_lambda" {
  #checkov:skip=CKV_AWS_116:The Lambda function is triggered by an EventBridge pattern-based rule.
  #checkov:skip=CKV_AWS_117:The Lambda function is part of a serverless implementation.
  #checkov:skip=CKV_AWS_173:No AWS KMS key provided to encrypt environment variables. Using AWS Lambda owned key.
  #checkov:skip=CKV_AWS_50:The Lambda function does not require X-Ray tracing and relies on CloudWatch Logs.

  filename      = "${path.module}/outputs/RootActivityLambda.zip"
  function_name = var.lambda_name
  role          = aws_iam_role.lambda_root_api_monitor_role.arn
  handler       = "RootActivityLambda.lambda_handler"
  timeout       = 15

  source_code_hash               = data.archive_file.RootActivityLambda.output_base64sha256
  runtime                        = "python3.12"
  reserved_concurrent_executions = 1

  environment {
    variables = {
      SNSARN =  var.sns_email_topic_arn
    }
  }
}


resource "aws_lambda_permission" "allow_sns" {
  statement_id  = "AllowSNSInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.root_activity_lambda.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = var.sns_invoker_arn
}

resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = var.sns_invoker_arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.root_activity_lambda.arn
}



