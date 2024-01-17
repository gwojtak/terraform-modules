## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.32.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.32.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_fargate_profile.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_fargate_profile) | resource |
| [aws_iam_role.fargate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.fargate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [terraform_data.exception](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [aws_iam_policy.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_subnet.fargate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster for this Fargate profile. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment this EKS profile is for. | `string` | n/a | yes |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | A list of tags to apply to all resources created with this module. | `map(any)` | n/a | yes |
| <a name="input_kubernetes_labels"></a> [kubernetes\_labels](#input\_kubernetes\_labels) | A mapping of extra kubernetes labels to apply to the profile. | `map(any)` | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace for description | `string` | `""` | no |
| <a name="input_profile_name"></a> [profile\_name](#input\_profile\_name) | The name to give to the created Fargate profile. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet ids that the fargate instances will use to run pods. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fargate_profile"></a> [fargate\_profile](#output\_fargate\_profile) | The Amazon EKS Fargate profile that was created. |
| <a name="output_pod_execution_role"></a> [pod\_execution\_role](#output\_pod\_execution\_role) | The object representing the IAM service role. |
| <a name="output_pod_subnets"></a> [pod\_subnets](#output\_pod\_subnets) | The objects representing the subnets into which the Fargate pods will run in. |
