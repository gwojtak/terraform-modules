## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.32.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.32.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.0.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.these](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_iam_openid_connect_provider.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_key.encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_security_group.remote](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.remote](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.remote_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_iam_policy_document.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_subnet.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [tls_certificate.eks](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_addons"></a> [cluster\_addons](#input\_cluster\_addons) | A list of EKS add-ons to request be installed. | <pre>list(object({<br>    name                = string<br>    version             = string<br>    configuration       = string<br>    service_account_arn = string<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_cluster_log_types"></a> [cluster\_log\_types](#input\_cluster\_log\_types) | A list of logging types to enable on the cluster. | `list(string)` | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | A name to give to the EKS cluster. | `string` | n/a | yes |
| <a name="input_cluster_role_name"></a> [cluster\_role\_name](#input\_cluster\_role\_name) | A name to give to the cluster role. | `string` | `null` | no |
| <a name="input_encryption_key"></a> [encryption\_key](#input\_encryption\_key) | The ARN of a KMS key to use for encryption.  Alternately, the value `CMK`, indicating this module should create and manage a key.  `null` for no encryption (not recommended). | `string` | `"CMK"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment that the cluster is a part of (dev, test, prod). | `string` | n/a | yes |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | A map representing tags to apply to all resources created with this module. | `map(any)` | `{}` | no |
| <a name="input_inbound_access_rules"></a> [inbound\_access\_rules](#input\_inbound\_access\_rules) | A list of maps defining allowed incoming connection by port, protocol, and cidr block | `map(any)` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Desired Kubernetes master version.  A null value tells EKS to use the latest version at creation time. | `string` | `null` | no |
| <a name="input_private_endpoint_enabled"></a> [private\_endpoint\_enabled](#input\_private\_endpoint\_enabled) | Controls whether to enable or disable Control Plane access from within the VPC. | `bool` | `true` | no |
| <a name="input_public_access_cidrs"></a> [public\_access\_cidrs](#input\_public\_access\_cidrs) | Provides a list of CIDRs for public IP address.  If the list is a null value, public access will be disabled all together. | `list(string)` | `[]` | no |
| <a name="input_remote_security_group_id"></a> [remote\_security\_group\_id](#input\_remote\_security\_group\_id) | The ID of the existing remote access security group to use, or null to create one. | `string` | `null` | no |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | The IPv4 CIDR block for the EKS cluster pod and service IP address allocation. | `string` | `"172.20.0.0/16"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet ids to place the cluster nodes into. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_cluster"></a> [eks\_cluster](#output\_eks\_cluster) | The created EKS cluster resource. |
| <a name="output_eks_cluster_addons"></a> [eks\_cluster\_addons](#output\_eks\_cluster\_addons) | A list of any created EKS addon resources. |
| <a name="output_eks_cluster_name"></a> [eks\_cluster\_name](#output\_eks\_cluster\_name) | The name of the EKS cluster that was created. |
| <a name="output_eks_oidc"></a> [eks\_oidc](#output\_eks\_oidc) | The created OpenID Connect (OIDC) provider object that was created. |
| <a name="output_eks_service_role"></a> [eks\_service\_role](#output\_eks\_service\_role) | The object of the IAM service role that was created with the module. |
