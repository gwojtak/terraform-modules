output "account_alias" {
  description = "The account alias that was set on the account."
  value       = aws_iam_account_alias.this
}

output "admin_group" {
  description = "The group created that has the administrator policy"
  value       = aws_iam_group.admin
}

output "admin_login_profile" {
  description = "The created login profile (password) for the account administrator user."
  value       = aws_iam_user_login_profile.admin
}

output "admin_user" {
  description = "The account administrator user that was created."
  value       = aws_iam_user.admin
}

output "password_policy" {
  description = "An object representing the password policy resource."
  value       = aws_iam_account_password_policy.this
}

output "saml_providers" {
  description = "A list of the SAML providers created with this module."
  value       = aws_iam_saml_provider.base
}
