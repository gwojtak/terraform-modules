output "cluster_id" {
  description = "The ID of the created DocumentDB (elastic or instance) cluster."
  value       = var.cluster_type == "instance" ? aws_docdb_cluster.main[0].id : aws_docdbelastic_cluster.main[0].id
}

output "cluster_instance_ids" {
  description = "The ID of the instances making up an instance-based cluster."
  value       = var.cluster_type == "instance" ? [for i in aws_docdb_cluster_instance.these : i.id] : null
}

output "kms_key_arn" {
  description = "The ARN of the KMS key that was created if `kms_key_id` was \"CMK\""
  value       = var.encryption_key == "CMK" ? aws_kms_key.encryption[0].arn : null
}

output "security_group_id" {
  description = "The ID of the security group created for controlling DocumentDB access."
  value       = aws_security_group.mongo.id
}

output "parameter_group_id" {
  description = "The ID of the cluster parameter group"
  value       = aws_docdb_cluster_parameter_group.this.id
}

output "subnet_group_id" {
  description = " The ID of the cluster's subnet group"
  value       = aws_docdb_subnet_group.that.id
}
