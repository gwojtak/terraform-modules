output "repo_arn" {
  description = "The ARN of the created ECR repository."
  value       = aws_ecr_repository.this.arn
}

output "ecr_repo" {
  description = "The created ECR repository resource object."
  value       = aws_ecr_repository.this
}
