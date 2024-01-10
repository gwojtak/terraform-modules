output "node_group_name" {
  description = "The name of the created node group."
  value       = aws_eks_node_group.this.node_group_name
}

output "node_group_arn" {
  description = "The ARN of the node group that was created."
  value       = aws_eks_node_group.this.arn
}

output "node_group" {
  description = "The created EKS node group object."
  value       = aws_eks_node_group.this
}

output "node_role" {
  description = "The created node role object."
  value       = aws_iam_role.node_role
}

output "managed_policies" {
  description = "A list of the managed policies attached to the node role."
  value       = [for pol in data.aws_iam_policy.node_policy : pol.arn]
}
