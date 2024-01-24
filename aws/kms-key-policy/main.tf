/**
 * # Amazon KMS Key Poilicy Module
 * 
 * Creates and manages a KMS key policy to attach to a given KMS key
 * See [KMS Key Module](https://github.com/gwojtak/terraform-modules/aws/kms-key) for the KMS Key module.
 *
 */

# Creates a KMS key policy and associates it with the specified KMS key
locals {
  conditions = { for cond in var.conditions : "${cond["variable"]}_${cond["test"]}" => cond["values"] }
}

data "aws_kms_key" "main" {
  key_id = var.kms_key_id
}

data "aws_iam_policy_document" "this" {
  statement {
    sid       = var.sid
    effect    = var.effect
    resources = [data.aws_kms_key.main.arn]
    actions   = var.actions

    principals {
      type        = var.principal_type
      identifiers = var.principal_identifiers
    }

    dynamic "condition" {
      for_each = local.conditions

      content {
        test     = split("_", condition.key)[1]
        values   = condition.value
        variable = split("_", condition.key)[0]
      }
    }
  }
}

resource "aws_kms_key_policy" "this" {
  key_id                             = data.aws_kms_key.main.key_id
  policy                             = data.aws_iam_policy_document.this.json
  bypass_policy_lockout_safety_check = false
}
