output "vpc_id" {
  description = "The id of the created VPC."
  value       = aws_vpc.this.id
}

output "elastic_ips" {
  description = "A list of aws_eip ojects created."
  value       = var.public_prefix_length > 0 ? aws_eip.nat : null
}

output "internet_gateway" {
  description = "The object of the created Internet Gateway."
  value       = var.public_prefix_length > 0 ? aws_internet_gateway.igw : null
}

output "nat_gateways" {
  description = "A list of the created NAT Gateway objects."
  value       = var.public_prefix_length > 0 ? aws_nat_gateway.private_gw : null
}

output "private_default_routes" {
  description = "A list of the created private default routes."
  value       = aws_route.private_ipv4_default
}

output "public_ipv4_default_routes" {
  description = "A list of the created IPv4 public default routes."
  value       = aws_route.public_ipv4_default
}

output "public_ipv6_default_routes" {
  description = "A list of the created IPv6 default routes."
  value       = aws_route.public_ipv6_default
}

output "private_route_table" {
  description = "A list of the created private route table objects."
  value       = var.private_prefix_length > 0 ? { for az in local.private_azs : az => aws_route_table.private[az] } : null
}

output "public_route_table" {
  description = "A list of t he created public route table objects."
  value       = var.public_prefix_length > 0 ? aws_route_table.public : null
}

output "private_subnets" {
  description = "A map of objects representing the created private subnets"
  value       = var.private_prefix_length > 0 ? { for az in local.private_azs : az => aws_subnet.private[az] } : null
}

output "public_subnets" {
  description = "A map of objects representing the created public subnets"
  value       = var.public_prefix_length > 0 ? { for az in local.public_azs : az => aws_subnet.public[az] } : null
}

output "vpc" {
  description = "The object representing the creted VPC."
  value       = aws_vpc.this
}
