/**
 * # Amazon IAM Role Profile Module
 * 
 * Creates and manages an IAM role
 *
 */

locals {
  canonical_users       = length(var.role_trust_canonicals) > 0 ? { CanonicalUser = var.role_trust_canonicals } : {}
  federated_policies    = length(var.role_trust_federated) > 0 ? { Federated = var.role_trust_federated } : {}
  instance_profile_name = "${local.role_name}-instance_profile"
  instance_profile_tags = merge(local.default_tags, { Name = local.instance_profile_name }, var.extra_tags)
  principal_policies    = length(var.role_trust_principals) > 0 ? { AWS = var.role_trust_principals } : {}
  role_name             = basename(var.role_name)
  role_path             = dirname(var.role_name) == "." ? "/" : "${dirname(var.role_name)}/"
  role_tags             = merge(local.default_tags, { Name = local.role_name }, var.extra_tags)
  service_policies      = length(var.role_trust_services) > 0 ? { Service = var.role_trust_services } : {}
  trust_policies        = merge(local.principal_policies, local.service_policies, local.federated_policies, local.canonical_users)
}

data "aws_iam_policy_document" "trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    dynamic "principals" {
      for_each = local.trust_policies

      content {
        type        = principals.key
        identifiers = principals.value
      }
    }
  }
}

resource "aws_iam_role" "this" {
  name        = local.role_name
  path        = local.role_path
  description = var.policy_description

  assume_role_policy = data.aws_iam_policy_document.trust.json

  tags = local.role_tags
}

resource "aws_iam_instance_profile" "this" {
  count = var.create_instance_profile ? 1 : 0

  name = local.instance_profile_name
  role = aws_iam_role.this.name

  tags = local.instance_profile_tags
}
