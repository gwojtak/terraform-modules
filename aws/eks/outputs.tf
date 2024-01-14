output "eks_cluster_name" {
  description = "The name of the EKS cluster that was created."
  value       = var.cluster_name
}

output "eks_cluster" {
  description = "The created EKS cluster resource."
  value       = aws_eks_cluster.main
}

output "eks_cluster_addons" {
  description = "A list of any created EKS addon resources."
  value       = aws_eks_addon.these
}

output "eks_oidc" {
  description = "The created OpenID Connect (OIDC) provider object that was created."
  value       = aws_iam_openid_connect_provider.main
}

output "eks_service_role" {
  description = "The object of the IAM service role that was created with the module."
  value       = aws_iam_role.eks
}
