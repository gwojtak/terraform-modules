output "security_group" {
  description = "The security group object that was created."
  value       = aws_security_group.this
}

output "security_group_rules" {
  description = "The security group's ingress rules."
  value       = concat([for rule in aws_security_group_rule.other : rule], [for rule in aws_security_group_rule.self : rule])
}

output "security_group_arn" {
  description = "The ARN of the created security group."
  value       = aws_security_group.this.arn
}

output "security_group_id" {
  description = "The ID of the created security group."
  value       = aws_security_group.this.id
}
