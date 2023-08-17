## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=5.10 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_instance_profile"></a> [create\_instance\_profile](#input\_create\_instance\_profile) | Controls whether to create an instance profile the the created role attached to it. | `bool` | `false` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Any tags to assign to all created resources can be passed in here. | `map(any)` | `{}` | no |
| <a name="input_managed_policy_names"></a> [managed\_policy\_names](#input\_managed\_policy\_names) | The names of AWS managed policies.  Required if `policy_document` is not defined. | `list(string)` | `[]` | no |
| <a name="input_policy_description"></a> [policy\_description](#input\_policy\_description) | Attach this descriptions to the created policies. | `string` | `""` | no |
| <a name="input_policy_document"></a> [policy\_document](#input\_policy\_document) | A string representing the JSON policy document.  Can be created with `aws_iam_policy_document` data source or `jsonencode()` function.  Required if `managed_policy` is not defined. | `string` | `""` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | Attach this description to the created role. | `string` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | This is the name of the created IAM role.  The name of the policy and optional instance profile are based off of this value. | `string` | n/a | yes |
| <a name="input_role_trust_canonicals"></a> [role\_trust\_canonicals](#input\_role\_trust\_canonicals) | A list of AWS CannonicalUser IDs that should be added to the role's trust policy.  Can be a list of CanonicalUser IDs or `*`. | `list(string)` | `[]` | no |
| <a name="input_role_trust_federated"></a> [role\_trust\_federated](#input\_role\_trust\_federated) | A list of web identity users or SAML provider ARNs that should be added to the role's trust policy.  Can be a list with a single element, `*`. | `list(string)` | `[]` | no |
| <a name="input_role_trust_principals"></a> [role\_trust\_principals](#input\_role\_trust\_principals) | A list of AWS ARNs that should be added to the role's trust policy.  Can be a list with a single element, `*`. | `list(string)` | `[]` | no |
| <a name="input_role_trust_services"></a> [role\_trust\_services](#input\_role\_trust\_services) | A list of AWS Service roles that should be added to the role's trust policy.  Can be a list with a single element, `*`. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_profile"></a> [instance\_profile](#output\_instance\_profile) | The object representing the optionally created instance profile. |
| <a name="output_managed_policies"></a> [managed\_policies](#output\_managed\_policies) | The managed policies attached to the role. |
| <a name="output_policy"></a> [policy](#output\_policy) | The object representing the created policy. |
| <a name="output_role"></a> [role](#output\_role) | The object representing the created role. |
| <a name="output_role_trust_policy"></a> [role\_trust\_policy](#output\_role\_trust\_policy) | The rendered trust policy for the created role. |
