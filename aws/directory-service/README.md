# AWS Directory Service Module

Creates a AWS managed Active Directory or Connector

TODO:
- domain trusts
- conditional forwarders
- regional replica
- shared directories
- log subscription

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.10 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_directory_service_directory.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/directory_service_directory) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ad_type"></a> [ad\_type](#input\_ad\_type) | The type of directory to deploy - SimpleAD, MicrosoftAD, or ADConnector | `string` | n/a | yes |
| <a name="input_customer_dns_ips"></a> [customer\_dns\_ips](#input\_customer\_dns\_ips) | If ad\_type is ADConnector, the IP addresses of the domain to connect to | `list(string)` | n/a | yes |
| <a name="input_customer_username"></a> [customer\_username](#input\_customer\_username) | If ad\_type is ADConnector, the username to connect to the directory with | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | A descriptive string to attach to the instance. | `string` | `""` | no |
| <a name="input_directory_size"></a> [directory\_size](#input\_directory\_size) | Only when directory\_type is SimpleAD or ADConnector - specify the size of the directory | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The fully qualified name for the directory. | `string` | n/a | yes |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | A map containing tags to apply to created resources | `map(any)` | `{}` | no |
| <a name="input_num_dcs"></a> [num\_dcs](#input\_num\_dcs) | n/a | `number` | `2` | no |
| <a name="input_password"></a> [password](#input\_password) | For SimpleAD and MicrosoftAD type, the password to set for the Admin.  For ADConnector types, this is the password to connect to the domain with. | `string` | n/a | yes |
| <a name="input_server_edition"></a> [server\_edition](#input\_server\_edition) | For MicrosoftAD type, specify Standard or Enterprise version of Active Directory | `string` | `null` | no |
| <a name="input_short_name"></a> [short\_name](#input\_short\_name) | The NetBIOS (short) name to give to the domain | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs in which to deploy the directories network interfaces | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC to create the directory in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dc_ips"></a> [dc\_ips](#output\_dc\_ips) | The IP addresses of the Domain Controllers (alias for dns\_ips) |
| <a name="output_directory_id"></a> [directory\_id](#output\_directory\_id) | ID of the created Directory Server or Connector |
| <a name="output_directory_type"></a> [directory\_type](#output\_directory\_type) | The type of the created directory |
| <a name="output_dns_ips"></a> [dns\_ips](#output\_dns\_ips) | The IP addresses of the DNS servers for the domain (alias for dc\_ips) |
| <a name="output_domain"></a> [domain](#output\_domain) | The domain name assigned to this Active Directory |
| <a name="output_netbios_name"></a> [netbios\_name](#output\_netbios\_name) | The short NetBIOS name of the domain |
| <a name="output_sso_enabled"></a> [sso\_enabled](#output\_sso\_enabled) | Whether SSO was enabled on the domain or not |
