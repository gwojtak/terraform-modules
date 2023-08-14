locals {
  vpc_default_tags  = merge(local.default_tags, { Name = var.name })
  vpc_resolved_tags = merge(local.vpc_default_tags, var.extra_tags)
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.enable_dns
  enable_dns_hostnames = var.enable_hostnames

  tags = local.vpc_resolved_tags
}
