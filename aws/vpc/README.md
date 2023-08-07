# AWS VPC Module

Creates a VPC and associated network-related resources

Currently supports
- vpc
- public / private subnets of variable sizes each
- Calculates subnet address space based on `vpc_cidr_block` and `public_mask_bits` or `private_mask_bits` variables
- deploy 0, 1, or 1-per-AZ NAT Gateways

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
| <a name="input_enable_ipv6"></a> [enable\_ipv6](#input\_enable\_ipv6) | Allows control of enabling IPv6 in the VPC | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Identifier for the environment that this VPC supports | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | A name to give to the VPC and associated resources | `string` | n/a | yes |
| <a name="input_num_azs"></a> [num\_azs](#input\_num\_azs) | The number of Availability Zones the VPC should span | `number` | `3` | no |
| <a name="input_num_nat_gws"></a> [num\_nat\_gws](#input\_num\_nat\_gws) | Number of NAT gateways to create (0=None, 1=One, >1=One Per AZ) | `number` | `0` | no |
| <a name="input_private_mask_bits"></a> [private\_mask\_bits](#input\_private\_mask\_bits) | Number of bits for the private subnet netmask | `number` | n/a | yes |
| <a name="input_public_mask_bits"></a> [public\_mask\_bits](#input\_public\_mask\_bits) | Number of bits for the public subnet netmask | `number` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block assigned to the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | A list of the availability zones the VPC spans |
| <a name="output_route_table_ids"></a> [route\_table\_ids](#output\_route\_table\_ids) | A map of public and private route table ids |
| <a name="output_subnet_cidrs"></a> [subnet\_cidrs](#output\_subnet\_cidrs) | A map of public and private subnet CIDR blocks |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | A map of public and private subnet ids |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | CIDR block of the vpc |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The id of the created vpc |
