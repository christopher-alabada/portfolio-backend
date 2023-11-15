resource "aws_lambda_function" "portfolio_python_backend" {
  function_name    = "${var.project_name}_${var.environment}"
  role             = "${var.aws_role}_${var.environment}"
  runtime          = "python3.11"
  handler          = "app.main.handler"
  s3_bucket        = var.project_bucket_name
  s3_key           = "${var.environment}/${var.s3_deploy_zipfile}"
  source_code_hash = var.source_code_hash

  environment {
    variables = {
      "ENVIRONMENT" = var.environment
    }
  }
}

resource "aws_lambda_permission" "portfolio_lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.portfolio_python_backend.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.portfolio_api.execution_arn}/*/*"
}

resource "aws_cloudwatch_log_group" "portfolio_python_backend" {
  name              = "/aws/lambda/${aws_lambda_function.portfolio_python_backend.function_name}"
  retention_in_days = 30
}
