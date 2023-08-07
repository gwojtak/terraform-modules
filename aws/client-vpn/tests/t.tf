terraform {
  required_version = "~> 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.10"
    }
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = var.profile
}

module "test" {
  source = "../"

  vpc_id                     = var.vpc_id
  certificate_arn            = var.certificate_arn
  client_cidr                = var.client_cidr
  dns_servers                = var.dns_servers
  cloudwatch_log_group       = var.cloudwatch_log_group
  auth_directory_id          = var.auth_directory_id
  subnet_id_associations     = var.subnet_id_associations
  routes                     = var.routes
  authorization_rules        = var.authorization_rules
  description                = var.description
  extra_tags                 = var.extra_tags
  enable_split_tunnel        = true
  enable_self_service_portal = true
}

output "test" {
  value = module.test
}
