output "kms_key" {
  description = "The object of the KMS key that was created."
  value       = aws_kms_key.main
}

output "key_alias" {
  description = "The object of the KMS key alias that was created."
  value       = aws_kms_key_alias.main
}

output "key_id" {
  description = "The ID of the KMS key that was created."
  value       = aws_kms_key.main.key_id
}

output "key_arn" {
  description = "The ARN of the KMS key that wsa created."
  value       = aws_kms_key.main.arn
}
