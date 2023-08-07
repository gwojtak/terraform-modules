terraform {
  required_version = ">=1.1.0"
}

provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "../"

  vpc_cidr_block    = "10.0.0.0/16"
  num_azs           = 3
  num_nat_gws       = 0
  name              = "MyVPC"
  environment       = "test"
  public_mask_bits  = 23
  private_mask_bits = 23
}

output "vpc_module" {
  value = module.vpc
}
