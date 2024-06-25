## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.other](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | A short explanation of the use of the security group. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The tier of the environment this system runs in (e.g. dev, uat, prod). | `string` | n/a | yes |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | A map of tags to apply to the security group resources in addition to the default tags. | `map(string)` | `{}` | no |
| <a name="input_inbound_rules"></a> [inbound\_rules](#input\_inbound\_rules) | A list of inbound access rules in the format of `PROTOCOL_PORT_SOURCE_COMMENT`.  `PORT` can take the format of a single port or a range (`START-END`).  `SOURCE` can be an IPv4 or IPv6 address, another security group id, or `self`. | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The name to give to the security group. | `string` | n/a | yes |
| <a name="input_outbound_rules"></a> [outbound\_rules](#input\_outbound\_rules) | A list of outbound access rules in the format of `PROTOCOL_PORT_SOURCE_COMMENT`.  `PORT` can take the format of a single port or a range (`START-END`).  `SOURCE` can be an IPv4 or IPv6 address, another security group id, or `self`. | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC in which to create the security group. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group"></a> [security\_group](#output\_security\_group) | The security group object that was created. |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | The ARN of the created security group. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the created security group. |
| <a name="output_security_group_rules"></a> [security\_group\_rules](#output\_security\_group\_rules) | The security group's ingress rules. |
