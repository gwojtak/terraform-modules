locals {
  role_name = var.cluster_role_name != null ? var.cluster_role_name : "${var.cluster_name}EKSServiceRole"
}

data "aws_iam_policy_document" "eks" {
  statement {
    sid     = "EKSClusterRolePolicy"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.eks.json

  tags = merge({ Name = local.role_name }, local.resolved_tags)
}

resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}
