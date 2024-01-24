## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.32.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.32.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_node_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_role.node_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_eks_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy.node_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.node_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_ssm_parameter.eks_ami_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_type"></a> [ami\_type](#input\_ami\_type) | The kind of AMI to run on the cluster nodes. | `string` | `"BOTTLEROCKET_x86_64"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster to attach this node group to. | `string` | n/a | yes |
| <a name="input_desired_size"></a> [desired\_size](#input\_desired\_size) | The desired number of nodes to be launched in the node group. | `number` | `1` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Sets the size of the disk (in GB) for the nodes to use. | `number` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the EKS node group runs | `string` | n/a | yes |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | A map of tags that should be applied to all created resources. | `map(any)` | `{}` | no |
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | A name to give to this node group. | `string` | `null` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | A list of instance types that the node group can contain. | `list(string)` | <pre>[<br>  "t3.medium"<br>]</pre> | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | An EC2 SSH key name for use with node access. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Kubernetes labels to apply to the nodes. | `map(any)` | `{}` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum number of nodes that should be launched within the node group. | `number` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum number of nodes that the node group can scale down to. | `number` | n/a | yes |
| <a name="input_remote_security_group_ids"></a> [remote\_security\_group\_ids](#input\_remote\_security\_group\_ids) | A list of CIDRs to allow access to the node group members. | `list(string)` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | A name to give to the ARN created for the instance. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs that the node group should use. | `list(string)` | n/a | yes |
| <a name="input_use_spot_instances"></a> [use\_spot\_instances](#input\_use\_spot\_instances) | Whether to use on-demand or spot instances. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_managed_policies"></a> [managed\_policies](#output\_managed\_policies) | A list of the managed policies attached to the node role. |
| <a name="output_node_group"></a> [node\_group](#output\_node\_group) | The created EKS node group object. |
| <a name="output_node_group_arn"></a> [node\_group\_arn](#output\_node\_group\_arn) | The ARN of the node group that was created. |
| <a name="output_node_group_name"></a> [node\_group\_name](#output\_node\_group\_name) | The name of the created node group. |
| <a name="output_node_role"></a> [node\_role](#output\_node\_role) | The created node role object. |

<!-- BEGIN TERRAFORM-DOCS -->
# Amazon EKS Node Group Module

Creates and manages node groups for EKS clusters.
See [EKS Cluster Module](https://github.com/gwojtak/terraform-modules/aws/eks) for the EKS module.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.32.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.32.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_node_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_role.node_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_eks_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy.node_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.node_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_ssm_parameter.eks_ami_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_type"></a> [ami\_type](#input\_ami\_type) | The kind of AMI to run on the cluster nodes. | `string` | `"BOTTLEROCKET_x86_64"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster to attach this node group to. | `string` | n/a | yes |
| <a name="input_desired_size"></a> [desired\_size](#input\_desired\_size) | The desired number of nodes to be launched in the node group. | `number` | `1` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Sets the size of the disk (in GB) for the nodes to use. | `number` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the EKS node group runs | `string` | n/a | yes |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | A map of tags that should be applied to all created resources. | `map(any)` | `{}` | no |
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | A name to give to this node group. | `string` | `null` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | A list of instance types that the node group can contain. | `list(string)` | <pre>[<br>  "t3.medium"<br>]</pre> | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | An EC2 SSH key name for use with node access. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Kubernetes labels to apply to the nodes. | `map(any)` | `{}` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum number of nodes that should be launched within the node group. | `number` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum number of nodes that the node group can scale down to. | `number` | n/a | yes |
| <a name="input_remote_security_group_ids"></a> [remote\_security\_group\_ids](#input\_remote\_security\_group\_ids) | A list of CIDRs to allow access to the node group members. | `list(string)` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | A name to give to the ARN created for the instance. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs that the node group should use. | `list(string)` | n/a | yes |
| <a name="input_use_spot_instances"></a> [use\_spot\_instances](#input\_use\_spot\_instances) | Whether to use on-demand or spot instances. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_managed_policies"></a> [managed\_policies](#output\_managed\_policies) | A list of the managed policies attached to the node role. |
| <a name="output_node_group"></a> [node\_group](#output\_node\_group) | The created EKS node group object. |
| <a name="output_node_group_arn"></a> [node\_group\_arn](#output\_node\_group\_arn) | The ARN of the node group that was created. |
| <a name="output_node_group_name"></a> [node\_group\_name](#output\_node\_group\_name) | The name of the created node group. |
| <a name="output_node_role"></a> [node\_role](#output\_node\_role) | The created node role object. |
<!-- END TERRAFORM-DOCS -->