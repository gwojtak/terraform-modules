output "instance_profile" {
  description = "The object representing the optionally created instance profile."
  value       = var.create_instance_profile ? aws_iam_instance_profile.this : null
}

output "managed_policies" {
  description = "The managed policies attached to the role."
  value       = values(data.aws_iam_policy.managed)
}
output "policy" {
  description = "The object representing the created policy."
  value       = var.policy_document != "" ? aws_iam_policy.this : null
}

output "role" {
  description = "The object representing the created role."
  value       = aws_iam_role.this
}

output "role_trust_policy" {
  description = "The rendered trust policy for the created role."
  value       = data.aws_iam_policy_document.trust.json
}
