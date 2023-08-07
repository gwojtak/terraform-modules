terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      version = ">= 5.10"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = var.profile
}

module "test" {
  source = "../"

  ad_type     = var.ad_type
  domain      = var.domain
  description = var.description
  subnet_ids  = var.subnet_ids
  password    = var.password
  vpc_id      = var.vpc_id
}
