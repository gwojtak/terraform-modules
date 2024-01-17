locals {
  default_tags = {
    Environment    = var.environment
    ManagedBy      = "Terraform"
    ResourceModule = "github.com/gwojtak/terraform-modules//aws/eks-fargate-profile"
    EKSCluster     = var.cluster_name
  }
  resolved_tags     = merge(local.default_tags, var.extra_tags)
  subnet_tag        = "kubernetes.io/cluster/${var.cluster_name}"
  subnet_tags_check = alltrue([for sn in data.aws_subnet.fargate : contains(keys(sn.tags), local.subnet_tag)])
}

data "aws_subnet" "fargate" {
  for_each = toset(var.subnet_ids)

  id = each.value
}

data "aws_iam_policy" "managed" {
  name = "AmazonEKSFargatePodExecutionRolePolicy"
}

data "aws_iam_policy_document" "trust" {
  statement {
    sid     = "EKSFargateTrustPolicy"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks-fargate-pods.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "fargate" {
  name               = "${var.profile_name}ProfileRole"
  assume_role_policy = data.aws_iam_policy_document.trust.json

  tags = merge({ Name = "${var.profile_name}ProfileRole", EKSCluster = var.cluster_name }, local.resolved_tags)
}

resource "aws_iam_role_policy_attachment" "fargate" {
  role       = aws_iam_role.fargate.name
  policy_arn = data.aws_iam_policy.managed.arn
}

resource "aws_eks_fargate_profile" "main" {
  cluster_name           = var.cluster_name
  fargate_profile_name   = var.profile_name
  pod_execution_role_arn = aws_iam_role.fargate.arn
  subnet_ids             = var.subnet_ids

  selector {
    namespace = var.namespace
    labels    = var.kubernetes_labels
  }
}

resource "terraform_data" "exception" {
  count = local.subnet_tags_check ? 0 : 1

  provisioner "local-exec" {
    command = "echo The tags on subnets referenced by subnet_ids are missing necessary tags.; exit 1"
  }
}
