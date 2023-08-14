locals {
  igw_resolved_tags = merge(local.default_tags, { Name = "${var.name} - Internet Gateway" }, var.extra_tags)
  nat_gw_azs        = var.public_prefix_length > 0 ? var.num_nat_gws == 0 ? [] : (var.num_nat_gws == 1 ? [local.azs[0]] : local.azs) : []
  eip_resolved_tags = merge(local.default_tags, { Name = "NAT Gateway" }, var.extra_tags)
}

resource "aws_internet_gateway" "igw" {
  count = var.public_prefix_length > 0 ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = local.igw_resolved_tags
}

resource "aws_eip" "nat" {
  for_each = toset(local.nat_gw_azs)

  domain = "vpc"

  tags = local.eip_resolved_tags
}

resource "aws_nat_gateway" "private_gw" {
  for_each = toset(local.nat_gw_azs)

  allocation_id     = aws_eip.nat[each.value].id
  subnet_id         = aws_subnet.public[each.value].id
  connectivity_type = "public"

  tags = merge({ Name = "NAT Gateway - ${local.abbreviated_azs[each.value]}" }, var.extra_tags)

  depends_on = [aws_internet_gateway.igw]
}
