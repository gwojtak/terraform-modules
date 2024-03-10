terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
}

module "test" {
  source = "../"

  name           = "test_repo"
  encryption_key = "AES256"
  environment    = "test"
}
