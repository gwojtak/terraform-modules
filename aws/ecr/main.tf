locals {
  default_tags = {
    Name           = var.name
    ManagedBy      = "Terraform"
    ResourceModule = "github.com/gwojtak/terraform-modules//aws/ecr"
    Environment    = var.environment
  }
  encryption_type = var.encryption_key == null || var.encryption_key == "AES256" ? var.encryption_key : "KMS"
  mutability      = var.immutable_tags ? "IMMUTABLE" : "MUTABLE"
}

resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = local.mutability

  dynamic "encryption_configuration" {
    for_each = local.encryption_type != null ? toset([lower(local.encryption_type)]) : toset([])

    content {
      encryption_type = local.encryption_type
      kms_key         = local.encryption_type == "KMS" ? var.encryption_key : null
    }
  }

  dynamic "image_scanning_configuration" {
    for_each = var.scan_image_on_push ? toset(["enabled"]) : toset([])

    content {
      scan_on_push = true
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}
