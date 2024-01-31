output "pod_subnets" {
  description = "The objects representing the subnets into which the Fargate pods will run in."
  value       = data.aws_subnet.fargate
}

output "pod_execution_role" {
  description = "The object representing the IAM service role."
  value       = aws_iam_role.fargate
}

output "fargate_profile" {
  description = "The Amazon EKS Fargate profile that was created."
  value       = aws_eks_fargate_profile.main
}
