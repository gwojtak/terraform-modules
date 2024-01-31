/**
 * # Amazon KMS Key Module
 * 
 * Creates and manages general use KMS keys.
 * See [KMS Key Policy Module](https://github.com/gwojtak/terraform-modules/aws/kms-key-policy) for managing Key Policies
 *
 */

locals {
  common_tags = {
    ManagedBy = "Terraform"
    Module    = "https://github.com/gwojtak/terraform/modules//aws/kms-key"
  }
  resolved_tags = merge(local.common_tags, var.extra_tags)
}

data "aws_caller_identity" "me" {}

resource "aws_kms_key" "main" {
  description             = var.key_description
  deletion_window_in_days = var.deletion_window

  tags = merge(var.key_alias != null ? { Name = var.key_alias } : {}, local.resolved_tags)
}

resource "aws_kms_key_alias" "main" {
  for_each = var.key_alias != null ? toset([var.key_alias]) : toset([])

  name          = startswith(var.key_alias, "alias/") ? var.key_alias : "alias/${var.key_alias}"
  target_key_id = aws_kms_key.main.key_id
}

data "aws_iam_policy_document" "key_policy" {
  statement {
    sid       = "Enable Root User Permissions"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.me.account_id}:root"]
    }
  }
}
