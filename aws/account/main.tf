/*
 * # AWS Account Initialization Module
 *
 * Does some typical account initialization tasks, such as setting MFA for root user,
 * setting password policy, account alias, and creating an admin user.
 */
locals {
  lowercase = contains(var.required_character_sets, "lowercase")
  numbers   = contains(var.required_character_sets, "numbers")
  symbols   = contains(var.required_character_sets, "symbols")
  uppercase = contains(var.required_character_sets, "uppercase")
  default_tags = merge({
    ManagedBy      = "Terraform"
    ResourceModule = "github.com/gwojtak/terraform-modules//aws/account"
    },
  var.extra_tags)
}

resource "aws_iam_account_password_policy" "this" {
  minimum_password_length        = var.min_password_length
  require_lowercase_characters   = local.lowercase
  require_numbers                = local.numbers
  require_symbols                = local.symbols
  require_uppercase_characters   = local.uppercase
  allow_users_to_change_password = var.allow_user_password_change
  hard_expiry                    = var.hard_expiry
  max_password_age               = var.max_password_age
  password_reuse_prevention      = var.password_reuse_count
}

resource "aws_iam_account_alias" "this" {
  account_alias = var.alias
}

resource "aws_iam_virtual_mfa_device" "root" {
  virtual_mfa_device_name = var.root_mfa_name

  tags = merge({ Name = var.root_mfa_name }, local.default_tags)
}

resource "aws_iam_saml_provider" "base" {
  for_each = var.saml_metadata

  name                   = each.key
  saml_metadata_document = each.value

  tags = merge({ Name = each.key }, local.default_tags)
}
