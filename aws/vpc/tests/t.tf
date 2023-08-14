terraform {
  required_version = ">=1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.10"
    }
  }
}

provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = {
      CreatedBy = "Module Testing"
    }
  }
}

module "vpc" {
  source = "../"

  vpc_cidr_block        = "192.168.0.0/16"
  num_azs               = 3
  num_nat_gws           = 0
  name                  = "MyVPC"
  environment           = "test"
  public_prefix_length  = 0
  private_prefix_length = 23
}

output "vpc_module" {
  value = module.vpc
}
