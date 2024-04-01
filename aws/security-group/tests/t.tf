provider "aws" {
  profile = var.profile
  region  = "us-east-2"
}

variable "profile" {}

data "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}

module "test" {
  source = "../"

  environment = "test"
  name        = "module_test_secgrp"
  inbound_rules = [
    "TCP_443_0.0.0.0/0_inbound HTTPS from everywhere",
    "UDP_123_99.23.0.1/32",
    "ALL_0-65535_self"
  ]
  outbound_rules = [
    "TCP_0-65535_0.0.0.0/0_outbound everywhere"
  ]
  description = "Testing functionaly of security-group module"
  vpc_id      = data.aws_vpc.this.id
}

output "test" {
  value = module.test
}
