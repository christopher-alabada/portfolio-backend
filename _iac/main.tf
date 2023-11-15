terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"
    }
  }
  backend "s3" {
    bucket = "<bucket_name>"
    region = "<aws_region>"
  }
}

provider "aws" {
  region = "<aws_region>"
}
