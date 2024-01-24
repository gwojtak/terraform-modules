# AWS VPC Module

Creates a VPC and associated network-related resources

Currently supports
- vpc
- public / private subnets of variable sizes each
- Calculates subnet address space based on `vpc_cidr_block` and `public_mask_bits` or `private_mask_bits` variables
- deploy 0, 1, or 1-per-AZ NAT Gateways

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
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
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.private_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private_ipv4_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_ipv4_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_ipv6_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.azs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_dns"></a> [enable\_dns](#input\_enable\_dns) | Controls the `enable_dns_support` attribue of the VPC. | `bool` | `true` | no |
| <a name="input_enable_hostnames"></a> [enable\_hostnames](#input\_enable\_hostnames) | Controls the `enable_dns_hostnames` attribute of the VPC | `bool` | `true` | no |
| <a name="input_enable_ipv6"></a> [enable\_ipv6](#input\_enable\_ipv6) | Allows control of enabling IPv6 in the VPC | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Identifier for the environment that this VPC supports | `string` | `null` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Allows passing in of tags to be applied to resources. | `map(any)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | A name to give to the VPC and associated resources | `string` | n/a | yes |
| <a name="input_num_azs"></a> [num\_azs](#input\_num\_azs) | The number of Availability Zones the VPC should span | `number` | `3` | no |
| <a name="input_num_nat_gws"></a> [num\_nat\_gws](#input\_num\_nat\_gws) | Number of NAT gateways to create (0=None, 1=One, >1=One Per AZ) | `number` | `0` | no |
| <a name="input_private_prefix_length"></a> [private\_prefix\_length](#input\_private\_prefix\_length) | Prefix length for the private subnet netmask.  Set to 0 to disable private subnets. | `number` | n/a | yes |
| <a name="input_public_prefix_length"></a> [public\_prefix\_length](#input\_public\_prefix\_length) | Prefix length for the public subnet netmask.  Set to 0 to disable public subnets. | `number` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block assigned to the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elastic_ips"></a> [elastic\_ips](#output\_elastic\_ips) | A list of aws\_eip ojects created. |
| <a name="output_internet_gateway"></a> [internet\_gateway](#output\_internet\_gateway) | The object of the created Internet Gateway. |
| <a name="output_nat_gateways"></a> [nat\_gateways](#output\_nat\_gateways) | A list of the created NAT Gateway objects. |
| <a name="output_private_default_routes"></a> [private\_default\_routes](#output\_private\_default\_routes) | A list of the created private default routes. |
| <a name="output_private_route_table"></a> [private\_route\_table](#output\_private\_route\_table) | A list of the created private route table objects. |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | A map of objects representing the created private subnets |
| <a name="output_public_ipv4_default_routes"></a> [public\_ipv4\_default\_routes](#output\_public\_ipv4\_default\_routes) | A list of the created IPv4 public default routes. |
| <a name="output_public_ipv6_default_routes"></a> [public\_ipv6\_default\_routes](#output\_public\_ipv6\_default\_routes) | A list of the created IPv6 default routes. |
| <a name="output_public_route_table"></a> [public\_route\_table](#output\_public\_route\_table) | A list of t he created public route table objects. |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | A map of objects representing the created public subnets |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | The object representing the creted VPC. |

<!-- BEGIN TERRAFORM-DOCS -->
# AWS VPC Module

Creates a VPC and associated network-related resources

Currently supports
- vpc
- public / private subnets of variable sizes each
- Calculates subnet address space based on `vpc_cidr_block` and `public_mask_bits` or `private_mask_bits` variables
- deploy 0, 1, or 1-per-AZ NAT Gateways

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
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.private_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private_ipv4_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_ipv4_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_ipv6_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.azs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_dns"></a> [enable\_dns](#input\_enable\_dns) | Controls the `enable_dns_support` attribue of the VPC. | `bool` | `true` | no |
| <a name="input_enable_hostnames"></a> [enable\_hostnames](#input\_enable\_hostnames) | Controls the `enable_dns_hostnames` attribute of the VPC | `bool` | `true` | no |
| <a name="input_enable_ipv6"></a> [enable\_ipv6](#input\_enable\_ipv6) | Allows control of enabling IPv6 in the VPC | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Identifier for the environment that this VPC supports | `string` | `null` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Allows passing in of tags to be applied to resources. | `map(any)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | A name to give to the VPC and associated resources | `string` | n/a | yes |
| <a name="input_num_azs"></a> [num\_azs](#input\_num\_azs) | The number of Availability Zones the VPC should span | `number` | `3` | no |
| <a name="input_num_nat_gws"></a> [num\_nat\_gws](#input\_num\_nat\_gws) | Number of NAT gateways to create (0=None, 1=One, >1=One Per AZ) | `number` | `0` | no |
| <a name="input_private_prefix_length"></a> [private\_prefix\_length](#input\_private\_prefix\_length) | Prefix length for the private subnet netmask.  Set to 0 to disable private subnets. | `number` | n/a | yes |
| <a name="input_private_subnet_extra_tags"></a> [private\_subnet\_extra\_tags](#input\_private\_subnet\_extra\_tags) | Extra tags to apply to private subnets. | `map(any)` | `{}` | no |
| <a name="input_public_prefix_length"></a> [public\_prefix\_length](#input\_public\_prefix\_length) | Prefix length for the public subnet netmask.  Set to 0 to disable public subnets. | `number` | n/a | yes |
| <a name="input_public_subnet_extra_tags"></a> [public\_subnet\_extra\_tags](#input\_public\_subnet\_extra\_tags) | Extra tags to apply public subnets. | `map(any)` | `{}` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block assigned to the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elastic_ips"></a> [elastic\_ips](#output\_elastic\_ips) | A list of aws\_eip ojects created. |
| <a name="output_internet_gateway"></a> [internet\_gateway](#output\_internet\_gateway) | The object of the created Internet Gateway. |
| <a name="output_nat_gateways"></a> [nat\_gateways](#output\_nat\_gateways) | A list of the created NAT Gateway objects. |
| <a name="output_private_default_routes"></a> [private\_default\_routes](#output\_private\_default\_routes) | A list of the created private default routes. |
| <a name="output_private_route_table"></a> [private\_route\_table](#output\_private\_route\_table) | A list of the created private route table objects. |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | A map of objects representing the created private subnets |
| <a name="output_public_ipv4_default_routes"></a> [public\_ipv4\_default\_routes](#output\_public\_ipv4\_default\_routes) | A list of the created IPv4 public default routes. |
| <a name="output_public_ipv6_default_routes"></a> [public\_ipv6\_default\_routes](#output\_public\_ipv6\_default\_routes) | A list of the created IPv6 default routes. |
| <a name="output_public_route_table"></a> [public\_route\_table](#output\_public\_route\_table) | A list of t he created public route table objects. |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | A map of objects representing the created public subnets |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | The object representing the creted VPC. |
<!-- END TERRAFORM-DOCS -->