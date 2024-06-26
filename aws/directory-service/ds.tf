locals {
  tags = {
    Environment    = var.environment
    ManagedBy      = "Terraform"
    ResourceModule = "github.com/gwojtak/terraform-modules//aws/directory-service"
  }
  resolved_tags = merge(local.tags, var.extra_tags)
  edition       = var.ad_type == "MicrosoftAD" ? var.server_edition : null
}

resource "aws_directory_service_directory" "this" {
  description = var.description
  name        = var.domain
  password    = var.password
  edition     = local.edition
  short_name  = var.short_name
  size        = var.directory_size
  type        = var.ad_type

  dynamic "vpc_settings" {
    for_each = var.ad_type != "ADConnector" ? toset([var.ad_type]) : toset([])

    content {
      subnet_ids = var.subnet_ids
      vpc_id     = var.vpc_id
    }
  }

  dynamic "connect_settings" {
    for_each = var.ad_type == "ADConnector" ? toset([var.ad_type]) : toset([])

    content {
      customer_dns_ips  = var.customer_dns_ips
      customer_username = var.customer_username
      subnet_ids        = var.subnet_ids
      vpc_id            = var.vpc_id
    }
  }

  lifecycle {
    ignore_changes = [password]
  }

  tags = merge({ Name = var.domain }, local.resolved_tags)
}
