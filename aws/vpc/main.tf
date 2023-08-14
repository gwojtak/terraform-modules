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

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      version = ">= 5.10"
      source  = "hashicorp/aws"
    }
  }
}

locals {
  abbreviated_azs = { for az in local.azs : az => substr(az, -2, 2) }
  azs             = slice(data.aws_availability_zones.azs.names, 0, var.num_azs)
  create_private  = var.private_prefix_length != 0
  create_public   = var.public_prefix_length != 0
  default_tags = {
    ManagedBy      = "Terraform"
    ResourceModule = "github.com/gwojtak/terraform-modules//aws/vpc"
    Environment    = var.environment
  }
}

data "aws_availability_zones" "azs" {}

data "aws_region" "current" {}
