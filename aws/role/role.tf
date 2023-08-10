locals {
  role_name             = basename(var.role_name)
  role_path             = dirname(var.role_name) == "." ? "/" : "${dirname(var.role_name)}/"
  instance_profile_name = "${local.role_name}-instance_profile"
  principal_policies    = length(var.role_trust_principals) > 0 ? { AWS = var.role_trust_principals } : {}
  service_policies      = length(var.role_trust_services) > 0 ? { Service = var.role_trust_services } : {}
  federated_policies    = length(var.role_trust_federated) > 0 ? { Federated = var.role_trust_federated } : {}
  canonicals_users      = length(var.role_trust_canonicals) > 0 ? { CanonicalUser = var.role_trust_canonicals } : {}
  trust_policies        = merge(local.principal_policies, local.service_policies)
  role_tags             = merge(var.extra_tags, { Name = local.role_name })
  instance_profile_tags = merge(var.extra_tags, { Name = local.instance_profile_name })
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
