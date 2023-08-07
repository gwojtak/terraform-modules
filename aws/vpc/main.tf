/**
 * # AWS VPC Module
 * 
 * Creates a VPC and associated network-related resources
 *
 * Currently supports
 * - vpc
 * - public / private subnets of variable sizes each
 * - Calculates subnet address space based on `vpc_cidr_block` and `public_mask_bits` or `private_mask_bits` variables
 * - deploy 0, 1, or 1-per-AZ NAT Gateways
 * 
 */

data "aws_availability_zones" "azs" {}

data "aws_region" "current" {}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name} | ${var.environment}"
  }
}
