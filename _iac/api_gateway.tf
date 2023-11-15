resource "aws_api_gateway_rest_api" "portfolio_api" {
  name = "${var.project_name}_${var.environment}"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "portfolio_api_resource" {
  rest_api_id = aws_api_gateway_rest_api.portfolio_api.id
  parent_id   = aws_api_gateway_rest_api.portfolio_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "portfolio_api_method" {
  rest_api_id   = aws_api_gateway_rest_api.portfolio_api.id
  resource_id   = aws_api_gateway_resource.portfolio_api_resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_method_settings" "portfolio_api_method_settings" {
  rest_api_id = aws_api_gateway_rest_api.portfolio_api.id
  stage_name  = aws_api_gateway_stage.portfolio_api.stage_name
  method_path = "*/*"
  settings {
    logging_level = "INFO"
  }
}

resource "aws_api_gateway_integration" "portfolio_api_integration" {
  rest_api_id             = aws_api_gateway_rest_api.portfolio_api.id
  resource_id             = aws_api_gateway_resource.portfolio_api_resource.id
  http_method             = aws_api_gateway_method.portfolio_api_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.portfolio_python_backend.invoke_arn
}

resource "aws_api_gateway_deployment" "portfolio_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.portfolio_api.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.portfolio_api_resource.id,
      aws_api_gateway_method.portfolio_api_method.id,
      aws_api_gateway_integration.portfolio_api_integration.id,
    ]))
  }
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_integration.portfolio_api_integration
  ]
}

resource "aws_api_gateway_stage" "portfolio_api" {
  rest_api_id   = aws_api_gateway_rest_api.portfolio_api.id
  deployment_id = aws_api_gateway_deployment.portfolio_api_deployment.id
  stage_name    = var.environment

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.portfolio_api.arn

    format = jsonencode({
      requestId      = "$context.requestId"
      sourceIp       = "$context.identity.sourceIp"
      caller         = "$context.identity.caller"
      user           = "$context.identity.user"
      requestTime    = "$context.requestTime"
      httpMethod     = "$context.httpMethod"
      resourcePath   = "$context.path"
      status         = "$context.status"
      protocol       = "$context.protocol"
      responseLength = "$context.responseLength"
      stage          = "$context.stage"
      }
    )
  }
}

resource "aws_cloudwatch_log_group" "portfolio_api" {
  name         = "/aws/ApiGatewayAccessLogs/${var.project_name}_${var.environment}"
  skip_destroy = true
}

resource "aws_api_gateway_account" "portfolio_api" {
  cloudwatch_role_arn = "${var.aws_role_apigateway}_${var.environment}"
}

output "base_url" {
  value = aws_api_gateway_deployment.portfolio_api_deployment.invoke_url
}
