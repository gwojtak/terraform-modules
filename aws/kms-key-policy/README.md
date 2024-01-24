<!-- BEGIN TERRAFORM-DOCS -->
# Amazon KMS Key Poilicy Module

Creates and manages a KMS key policy to attach to a given KMS key
See [KMS Key Module](https://github.com/gwojtak/terraform-modules/aws/kms-key) for the KMS Key module.

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
| [aws_kms_key_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions"></a> [actions](#input\_actions) | A list of the KMS actions to allow for the given principals. | `list(string)` | n/a | yes |
| <a name="input_conditions"></a> [conditions](#input\_conditions) | A list of condition variables, packed as an object with attributes `test` and `values` | <pre>list(object({<br>    variable = string<br>    test     = string<br>    values   = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_effect"></a> [effect](#input\_effect) | Whether to allow or deny the actions. | `string` | `"Allow"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ID, ARN, Alias, or Alias ARN of the key to attach the policy to. | `string` | n/a | yes |
| <a name="input_principal_identifiers"></a> [principal\_identifiers](#input\_principal\_identifiers) | The identifiers of the principals (ARNs, for example). | `list(string)` | n/a | yes |
| <a name="input_principal_type"></a> [principal\_type](#input\_principal\_type) | The type of the principal. | `string` | n/a | yes |
| <a name="input_sid"></a> [sid](#input\_sid) | The description to give to the policy (sets the SID) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_key_policy"></a> [kms\_key\_policy](#output\_kms\_key\_policy) | The KMS Key Policy object. |
<!-- END TERRAFORM-DOCS -->