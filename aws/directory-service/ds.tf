locals {
  tags = {
    ManagedBy = "Terraform"
    Module    = "github.com/gwojtak/terraform-modules//aws/directory-service"
  }
  resolved_tags = merge(local.tags, var.extra_tags)
}

resource "aws_directory_service_directory" "this" {
  description = var.description
  name        = var.domain
  password    = var.password
  size        = var.directory_size
  type        = var.ad_type

  dynamic "vpc_settings" {
    for_each = var.ad_type != "ADConnector" ? [var.ad_type] : []

    content {
      subnet_ids = var.subnet_ids
      vpc_id     = var.vpc_id
    }
  }

  dynamic "connect_settings" {
    for_each = var.ad_type == "ADConnector" ? [var.ad_type] : []

    content {
      customer_dns_ips  = var.customer_dns_ips
      customer_username = var.customer_username
      subnet_ids        = var.subnet_ids
      vpc_id            = var.vpc_id
    }
  }

  tags = local.resolved_tags
}
