/**
 * # Amazon EKS Module
 * 
 * Creates an EKS cluster and manages cluster add-ons.
 *
 * For compute resources, see the [eks-fargate-profile module](https://github.com/gwojtak/terraform-modules/aws/eks-fargate-profile) and/or the [eks-node-group module](https://github.com/gwojtak/terraform-modules/aws/eks-node-group)
 *
 */

locals {
  default_tags = {
    Environment    = var.environment
    ManagedBy      = "Terraform"
    ResourceModule = "github.com/gwojtak/terraform-modules//aws/eks"
  }
  resolved_tags = merge(local.default_tags, var.extra_tags)
  kms_key_arn   = var.encryption_key == "CMK" ? aws_kms_key.encryption["eks_secrets"].arn : var.encryption_key
  addons = { for i in var.cluster_addons : i["name"] => {
    version             = i["version"]
    configuration       = i["configuration"]
    service_account_arn = i["service_account_arn"]
  } }
}

resource "aws_kms_key" "encryption" {
  for_each = var.encryption_key == "CMK" ? toset(["eks_secrets"]) : toset([])

  description             = "Secrets encryption key for ${var.cluster_name} EKS cluster."
  deletion_window_in_days = 7

  tags = merge({ Name = "${var.cluster_name}EncryptionKey" }, local.resolved_tags)
}

resource "aws_eks_addon" "these" {
  for_each = local.addons

  addon_name                  = each.key
  addon_version               = each.value["version"]
  cluster_name                = aws_eks_cluster.main.name
  configuration_values        = each.value["configuration"]
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  service_account_role_arn    = try(each.value["service_account_arn"], null)

  tags = merge(local.resolved_tags, { Name = "${var.cluster_name}-${each.key}", Cluster = aws_eks_cluster.main.name })
}

resource "aws_eks_cluster" "main" {
  name                      = var.cluster_name
  role_arn                  = aws_iam_role.eks.arn
  enabled_cluster_log_types = var.cluster_log_types

  dynamic "encryption_config" {
    for_each = local.kms_key_arn != null ? toset([local.kms_key_arn]) : toset([])

    content {
      resources = ["secrets"]
      provider {
        key_arn = local.kms_key_arn
      }
    }
  }

  kubernetes_network_config {
    ip_family         = "ipv4"
    service_ipv4_cidr = var.service_cidr
  }

  vpc_config {
    endpoint_private_access = var.private_endpoint_enabled
    endpoint_public_access  = var.public_access_cidrs == null ? false : true
    public_access_cidrs     = var.public_access_cidrs
    security_group_ids      = [local.remote_sg_id]
    subnet_ids              = var.subnet_ids
  }

  access_config {
    authentication_mode                         = "CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  tags = merge({ Name = var.cluster_name }, local.resolved_tags)
}

data "tls_certificate" "eks" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "main" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.eks.url

  tags = merge({ Name = "OIDC Provider for ${var.cluster_name}" }, local.resolved_tags)
}
