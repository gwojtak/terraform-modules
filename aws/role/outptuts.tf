output "instance_profile" {
  description = "The object representing the optionally created instance profile."
  value       = var.create_instance_profile ? aws_iam_instance_profile.this : null
}

output "policy" {
  description = "The object representing the created policy."
  value       = aws_iam_policy.this
}

output "role" {
  description = "The object representing the created role."
  value       = aws_iam_role.this
}

output "role_trust_policy" {
  description = "The rendered trust policy for the created role."
  value       = data.aws_iam_policy_document.trust.json
}
