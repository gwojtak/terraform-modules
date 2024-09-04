resource "aws_route_table" "public" {
  count = var.public_prefix_length > 0 ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table" "private" {
  for_each = toset(local.private_azs)

  vpc_id = aws_vpc.this.id

  tags = merge({ Name = "Private Route Table - ${each.value}" }, local.default_tags, var.extra_tags)
}

resource "aws_route" "public_ipv6_default" {
  count = var.enable_ipv6 ? 1 : 0

  route_table_id              = aws_route_table.public[0].id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.igw[0].id
}

resource "aws_route" "public_ipv4_default" {
  count = var.public_prefix_length > 0 ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw[0].id
}

resource "aws_route" "private_ipv4_default" {
  for_each = length(local.nat_gw_azs) > 0 && var.public_prefix_length > 0 ? toset(local.private_azs) : toset([])

  route_table_id         = aws_route_table.private[each.value].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = length(local.nat_gw_azs) > 1 ? aws_nat_gateway.private_gw[each.value].id : aws_nat_gateway.private_gw[local.public_azs[0]].id
}

resource "aws_route_table_association" "public" {
  for_each = toset(local.public_azs)

  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public[each.value].id
}

resource "aws_route_table_association" "private" {
  for_each = toset(local.private_azs)

  route_table_id = aws_route_table.private[each.value].id
  subnet_id      = aws_subnet.private[each.value].id
}
