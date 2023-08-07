locals {
  nat_gw_azs      = var.num_nat_gws == 0 ? [] : (var.num_nat_gws == 1 ? [local.azs[0]] : local.azs)
  abbreviated_azs = { for az in local.azs : az => substr(az, -2, 2) }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name} - ${var.environment} - Internet Gateway"
  }
}

resource "aws_eip" "nat" {
  for_each = toset(local.nat_gw_azs)

  vpc = true

  tags = {
    Name = "NAT Gateway - ${local.abbreviated_azs[each.value]}"
  }
}

resource "aws_nat_gateway" "private_gw" {
  for_each = toset(local.nat_gw_azs)

  allocation_id     = aws_eip.nat[each.value].id
  subnet_id         = aws_subnet.public[each.value].id
  connectivity_type = "public"

  tags = {
    Name = "NAT Gateway - ${local.abbreviated_azs[each.value]}"
  }

  depends_on = [aws_internet_gateway.igw]
}

