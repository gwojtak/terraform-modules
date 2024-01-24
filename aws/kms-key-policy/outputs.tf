output "kms_key_policy" {
  description = "The KMS Key Policy object."
  value       = aws_kms_key_policy.this
}
