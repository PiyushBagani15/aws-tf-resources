terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.29.0"
    }
  }
  cloud {
    organization = "aws-test-resources"

    workspaces {
      name = "aws-test"
    }
  }
  required_version = ">= 0.14"
}