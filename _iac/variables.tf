variable "project_name" {
  type    = string
  default = "portfolio_backend"
}

variable "project_bucket_name" {
  type    = string
  default = "<bucket_name>"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "aws_region" {
  type    = string
  default = "<aws_region>"
}

variable "site_domain" {
  type = string
}

variable "s3_deploy_zipfile" {
  type = string
}

variable "aws_role" {
  type = string
}

variable "aws_role_apigateway" {
  type = string
}

variable "aws_certificate_arn" {
  type = string
}

variable "source_code_hash" {
  type = string
}
