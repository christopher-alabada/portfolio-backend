resource "aws_api_gateway_domain_name" "portfolio_api_domain_name" {
  domain_name              = var.site_domain
  regional_certificate_arn = var.aws_certificate_arn
  security_policy          = "TLS_1_2"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "portfolio_api_mapping" {
  api_id      = aws_api_gateway_rest_api.portfolio_api.id
  stage_name  = aws_api_gateway_stage.portfolio_api.stage_name
  domain_name = aws_api_gateway_domain_name.portfolio_api_domain_name.domain_name
}
