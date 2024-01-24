<!-- BEGIN TERRAFORM-DOCS -->
# Amazon KMS Key Module

Creates and manages general use KMS keys.
See [KMS Key Policy Module](https://github.com/gwojtak/terraform-modules/aws/kms-key-policy) for managing Key Policies

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
| [aws_kms_key.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_alias.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_alias) | resource |
| [aws_iam_policy_document.key_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_sts_caller_identity.me](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sts_caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deletion_window"></a> [deletion\_window](#input\_deletion\_window) | The number of days that a key will wait to be deleted after being scheduled. | `number` | `30` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which this key is used (dev, production, etc). | `string` | n/a | yes |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Tags to add to the resources in addition to the default module tags. | `map(any)` | `{}` | no |
| <a name="input_key_alias"></a> [key\_alias](#input\_key\_alias) | If set, create an alias to assign to the created key. | `string` | `null` | no |
| <a name="input_key_description"></a> [key\_description](#input\_key\_description) | A description to give to the created key. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_alias"></a> [key\_alias](#output\_key\_alias) | The object of the KMS key alias that was created. |
| <a name="output_key_arn"></a> [key\_arn](#output\_key\_arn) | The ARN of the KMS key that wsa created. |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | The ID of the KMS key that was created. |
| <a name="output_kms_key"></a> [kms\_key](#output\_kms\_key) | The object of the KMS key that was created. |
<!-- END TERRAFORM-DOCS -->