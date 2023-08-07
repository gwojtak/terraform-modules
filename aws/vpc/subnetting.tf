locals {
  azs           = slice(data.aws_availability_zones.azs.names, 0, var.num_azs)
  vpc_mask_bits = substr(var.vpc_cidr_block, -2, 2)
  bits_delta = {
    private  = abs(var.private_mask_bits - local.vpc_mask_bits)
    public   = abs(var.public_mask_bits - local.vpc_mask_bits)
    priv2pub = abs(var.private_mask_bits - var.public_mask_bits)
  }
  base_offset = {
    public  = var.private_mask_bits <= var.public_mask_bits ? pow(2, local.bits_delta["priv2pub"]) * var.num_azs : 0
    private = var.public_mask_bits < var.private_mask_bits ? pow(2, local.bits_delta["priv2pub"]) * var.num_azs : 0
  }
  cidr_blocks = {
    public = {
      for az in local.azs : az => cidrsubnet(var.vpc_cidr_block, local.bits_delta["public"], index(local.azs, az) + local.base_offset["public"])
    }
    private = {
      for az in local.azs : az => cidrsubnet(var.vpc_cidr_block, local.bits_delta["private"], index(local.azs, az) + local.base_offset["private"])
    }
  }
}

resource "aws_subnet" "public" {
  for_each = toset(local.azs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.cidr_blocks["public"][each.value]
  availability_zone       = each.value
  map_public_ip_on_launch = true

  tags = {
    Name = "Public | ${var.environment} | ${local.abbreviated_azs[each.value]}"
  }
}

resource "aws_subnet" "private" {
  for_each = toset(local.azs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.cidr_blocks["private"][each.value]
  availability_zone       = each.value
  map_public_ip_on_launch = false

  tags = {
    Name = "Private | ${var.environment} | ${local.abbreviated_azs[each.value]}"
  }
}
