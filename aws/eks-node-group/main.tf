locals {
  default_tags = {
    Environment    = var.environment
    ManagedBy      = "Terraform"
    ResourceModule = "github.com/gwojtak/terraform-modules//aws/eks-node-group"
  }
  resolved_tags = merge(local.default_tags, var.extra_tags)
  node_policies = [for policy in data.aws_iam_policy.node_policy : policy.name]
  role_name     = var.role_name != null ? var.role_name : "${var.cluster_name}-node-policy"
  disk_size     = var.disk_size == null ? (startswith(var.ami_type, "WINDOWS") ? 50 : 20) : var.disk_size
  group_name    = var.group_name != null ? var.group_name : "${data.aws_eks_cluster.main.name}-${var.group_name}"
  ami_type_mappings = {
    AL2_x86_64     = "amazon-linux-2",
    AL2_x86_64_GPU = "amazon-linux-2-gpu",
    AL2_ARM_64     = "amazon-linux-2-arm64"
  }
}

data "aws_eks_cluster" "main" {
  name = var.cluster_name
}

data "aws_ssm_parameter" "eks_ami_version" {
  name = "/aws/service/eks/optimized-ami/${data.aws_eks_cluster.main.version}/${local.ami_type_mappings[var.ami_type]}/recommended/release_version"
}

resource "aws_eks_node_group" "this" {
  cluster_name    = data.aws_eks_cluster.main.name
  node_group_name = local.group_name
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  update_config {
    max_unavailable = 1
  }

  ami_type      = var.ami_type
  capacity_type = var.use_spot_instances ? "SPOT" : "ON_DEMAND"
  disk_size     = local.disk_size
  #   force_update_version = ""
  instance_types  = var.instance_types
  labels          = var.labels
  release_version = startswith(var.ami_type, "AL2") ? nonsensitive(data.aws_ssm_parameter.eks_ami_version.value) : null

  remote_access {
    ec2_ssh_key               = var.key_name
    source_security_group_ids = var.remote_security_group_ids
  }

  tags = merge({ Name = local.group_name, EKSCluster = data.aws_eks_cluster.main.name }, local.resolved_tags)
}

data "aws_iam_policy_document" "node_trust" {
  statement {
    sid     = "EKSNodeServiceRoleTrustPolicy"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "node_policy" {
  for_each = toset(["AmazonEC2ContainerRegistryReadOnly", "AmazonEKS_CNI_Policy", "AmazonEKSWorkerNodePolicy"])

  name = each.value
}

resource "aws_iam_role" "node_role" {
  assume_role_policy = data.aws_iam_policy_document.node_trust.json
  description        = "EC2 node policy for ${var.cluster_name} EKS cluster."
  name               = local.role_name

  tags = merge({ Name = local.role_name }, local.resolved_tags)
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = toset(local.node_policies)

  policy_arn = data.aws_iam_policy.node_policy[each.value].arn
  role       = aws_iam_role.node_role.name
}
