# AWS Client VPN Endpoint Module

Creates a Client VPN Endpoint

Suports
- Different authorization types
- Authorization rules
- Routes
- Split tunnels
- Custom DNS Server serttings

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_client_vpn_authorization_rule.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule) | resource |
| [aws_ec2_client_vpn_authorization_rule.groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule) | resource |
| [aws_ec2_client_vpn_endpoint.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint) | resource |
| [aws_ec2_client_vpn_network_association.these](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_ec2_client_vpn_route.these](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_route) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_certificate_arn"></a> [auth\_certificate\_arn](#input\_auth\_certificate\_arn) | If set, use this certificate for client authentication | `string` | `null` | no |
| <a name="input_auth_directory_id"></a> [auth\_directory\_id](#input\_auth\_directory\_id) | If set, use this Active Directory for client authentication | `string` | `null` | no |
| <a name="input_auth_saml_arn"></a> [auth\_saml\_arn](#input\_auth\_saml\_arn) | If set, use this SAML provider for client authentication | `string` | `null` | no |
| <a name="input_authorization_rules"></a> [authorization\_rules](#input\_authorization\_rules) | An map of authorization rules for target subnets and group.  Use ALL if authorization by group is not desired or applicable | <pre>list(object(<br>    {<br>      authorize   = string<br>      cidr        = string<br>      description = string<br>    }<br>  ))</pre> | n/a | yes |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | The ARN of the certificate to use for the server connection.  If not specified, a new one will be created. | `string` | n/a | yes |
| <a name="input_client_cidr"></a> [client\_cidr](#input\_client\_cidr) | The IP address range for client machines | `string` | `"10.255.0.0/23"` | no |
| <a name="input_cloudwatch_log_group"></a> [cloudwatch\_log\_group](#input\_cloudwatch\_log\_group) | A name to give to the cloudwatch log group.  If empty, don't use cloudwatch logs | `string` | `null` | no |
| <a name="input_cloudwatch_log_stream"></a> [cloudwatch\_log\_stream](#input\_cloudwatch\_log\_stream) | A name to give to the cloudwatch log stream. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Descriptive text to assign to the description field for the VPN client connection | `string` | `""` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | Force VPN clients to use these DNS servers.  Defaults to the VPC DNS server. | `list(string)` | `[]` | no |
| <a name="input_enable_self_service_portal"></a> [enable\_self\_service\_portal](#input\_enable\_self\_service\_portal) | Controls whether the VPN Endpoint's self-service portal should be enabled or disabled | `bool` | `false` | no |
| <a name="input_enable_split_tunnel"></a> [enable\_split\_tunnel](#input\_enable\_split\_tunnel) | Controls whether all traffic should flow through VPN or only specific routes | `bool` | `true` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Any extra tags to assign to these resources | `map(string)` | `{}` | no |
| <a name="input_login_banner"></a> [login\_banner](#input\_login\_banner) | The text of the login banner to display upon client connection | `string` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | The port for the VPN connection to use | `number` | `1194` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | Select UDP or TCP for the VPN protocol | `string` | `"udp"` | no |
| <a name="input_routes"></a> [routes](#input\_routes) | A map that defines target networks and the gateway to them | <pre>list(object(<br>    {<br>      description = string<br>      to          = string<br>      via         = string<br>    }<br>  ))</pre> | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of security groups to assign to the target network | `list(string)` | `null` | no |
| <a name="input_self_service_saml_provider_arn"></a> [self\_service\_saml\_provider\_arn](#input\_self\_service\_saml\_provider\_arn) | TRhe ARN of the IAM SAML identity provider for the self service portal if type is federated-authentication. | `string` | `null` | no |
| <a name="input_subnet_id_associations"></a> [subnet\_id\_associations](#input\_subnet\_id\_associations) | The subnet IDs that the VPN endpoint should be associated with | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of the VPC to create the client vpn connection into | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allow_all_authorization_rules"></a> [allow\_all\_authorization\_rules](#output\_allow\_all\_authorization\_rules) | The VPN authorization rules that allow all regardless of groups |
| <a name="output_client_cidr_block"></a> [client\_cidr\_block](#output\_client\_cidr\_block) | The created endpoint's CIDR block |
| <a name="output_client_vpn_id"></a> [client\_vpn\_id](#output\_client\_vpn\_id) | The ID of the created client VPN endpoint |
| <a name="output_dns_servers"></a> [dns\_servers](#output\_dns\_servers) | A list of the DNS servers that the clients will use when connected to VPN |
| <a name="output_groups_authorization_rules"></a> [groups\_authorization\_rules](#output\_groups\_authorization\_rules) | The VPN authorization rules that allow based on group membership in the directory |
| <a name="output_port"></a> [port](#output\_port) | The port (443 or 1194) on which the VPN runs |
| <a name="output_protocol"></a> [protocol](#output\_protocol) | VPN can run on either UDP or TCP, this tells what the endpoint uses |
| <a name="output_routes"></a> [routes](#output\_routes) | All client routes configured for this endpoint |
| <a name="output_self_service_portal"></a> [self\_service\_portal](#output\_self\_service\_portal) | The URL of the Self-Service Portal for this VPN endpoint |

<!-- BEGIN TERRAFORM-DOCS -->
# AWS Client VPN Endpoint Module

Creates a Client VPN Endpoint

Suports
- Different authorization types
- Authorization rules
- Routes
- Split tunnels
- Custom DNS Server serttings

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
| [aws_ec2_client_vpn_authorization_rule.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule) | resource |
| [aws_ec2_client_vpn_authorization_rule.groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule) | resource |
| [aws_ec2_client_vpn_endpoint.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint) | resource |
| [aws_ec2_client_vpn_network_association.these](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_ec2_client_vpn_route.these](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_route) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_certificate_arn"></a> [auth\_certificate\_arn](#input\_auth\_certificate\_arn) | If set, use this certificate for client authentication | `string` | `null` | no |
| <a name="input_auth_directory_id"></a> [auth\_directory\_id](#input\_auth\_directory\_id) | If set, use this Active Directory for client authentication | `string` | `null` | no |
| <a name="input_auth_saml_arn"></a> [auth\_saml\_arn](#input\_auth\_saml\_arn) | If set, use this SAML provider for client authentication | `string` | `null` | no |
| <a name="input_authorization_rules"></a> [authorization\_rules](#input\_authorization\_rules) | An map of authorization rules for target subnets and group.  Use ALL if authorization by group is not desired or applicable | <pre>list(object(<br>    {<br>      authorize   = string<br>      cidr        = string<br>      description = string<br>    }<br>  ))</pre> | n/a | yes |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | The ARN of the certificate to use for the server connection.  If not specified, a new one will be created. | `string` | n/a | yes |
| <a name="input_client_cidr"></a> [client\_cidr](#input\_client\_cidr) | The IP address range for client machines | `string` | `"10.255.0.0/23"` | no |
| <a name="input_cloudwatch_log_group"></a> [cloudwatch\_log\_group](#input\_cloudwatch\_log\_group) | A name to give to the cloudwatch log group.  If empty, don't use cloudwatch logs | `string` | `null` | no |
| <a name="input_cloudwatch_log_stream"></a> [cloudwatch\_log\_stream](#input\_cloudwatch\_log\_stream) | A name to give to the cloudwatch log stream. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Descriptive text to assign to the description field for the VPN client connection | `string` | `""` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | Force VPN clients to use these DNS servers.  Defaults to the VPC DNS server. | `list(string)` | `[]` | no |
| <a name="input_enable_self_service_portal"></a> [enable\_self\_service\_portal](#input\_enable\_self\_service\_portal) | Controls whether the VPN Endpoint's self-service portal should be enabled or disabled | `bool` | `false` | no |
| <a name="input_enable_split_tunnel"></a> [enable\_split\_tunnel](#input\_enable\_split\_tunnel) | Controls whether all traffic should flow through VPN or only specific routes | `bool` | `true` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Any extra tags to assign to these resources | `map(string)` | `{}` | no |
| <a name="input_login_banner"></a> [login\_banner](#input\_login\_banner) | The text of the login banner to display upon client connection | `string` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | The port for the VPN connection to use | `number` | `1194` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | Select UDP or TCP for the VPN protocol | `string` | `"udp"` | no |
| <a name="input_routes"></a> [routes](#input\_routes) | A map that defines target networks and the gateway to them | <pre>list(object(<br>    {<br>      description = string<br>      to          = string<br>      via         = string<br>    }<br>  ))</pre> | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of security groups to assign to the target network | `list(string)` | `null` | no |
| <a name="input_self_service_saml_provider_arn"></a> [self\_service\_saml\_provider\_arn](#input\_self\_service\_saml\_provider\_arn) | TRhe ARN of the IAM SAML identity provider for the self service portal if type is federated-authentication. | `string` | `null` | no |
| <a name="input_subnet_id_associations"></a> [subnet\_id\_associations](#input\_subnet\_id\_associations) | The subnet IDs that the VPN endpoint should be associated with | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of the VPC to create the client vpn connection into | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allow_all_authorization_rules"></a> [allow\_all\_authorization\_rules](#output\_allow\_all\_authorization\_rules) | The VPN authorization rules that allow all regardless of groups |
| <a name="output_client_cidr_block"></a> [client\_cidr\_block](#output\_client\_cidr\_block) | The created endpoint's CIDR block |
| <a name="output_client_vpn_id"></a> [client\_vpn\_id](#output\_client\_vpn\_id) | The ID of the created client VPN endpoint |
| <a name="output_dns_servers"></a> [dns\_servers](#output\_dns\_servers) | A list of the DNS servers that the clients will use when connected to VPN |
| <a name="output_groups_authorization_rules"></a> [groups\_authorization\_rules](#output\_groups\_authorization\_rules) | The VPN authorization rules that allow based on group membership in the directory |
| <a name="output_port"></a> [port](#output\_port) | The port (443 or 1194) on which the VPN runs |
| <a name="output_protocol"></a> [protocol](#output\_protocol) | VPN can run on either UDP or TCP, this tells what the endpoint uses |
| <a name="output_routes"></a> [routes](#output\_routes) | All client routes configured for this endpoint |
| <a name="output_self_service_portal"></a> [self\_service\_portal](#output\_self\_service\_portal) | The URL of the Self-Service Portal for this VPN endpoint |
<!-- END TERRAFORM-DOCS -->