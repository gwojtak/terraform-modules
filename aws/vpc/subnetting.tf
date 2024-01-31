locals {
  all_cidrs = cidrsubnets(var.vpc_cidr_block,
    concat(
      [for i in local.public_azs : local.prefix_diffs["public"]],
      [for i in local.private_azs : local.prefix_diffs["private"]]
    )...
  )
  cidr_blocks = {
    private = local.create_private ? zipmap(local.private_azs, slice(local.all_cidrs, local.offsets["private"], local.offsets["private"] + var.num_azs)) : null
    public  = local.create_public ? zipmap(local.public_azs, slice(local.all_cidrs, 0, var.num_azs)) : null
  }
  offsets = {
    private = local.create_private ? length(local.public_azs) : null
    public  = local.create_public ? 0 : null
  }
  prefix_diffs = {
    private = local.create_private ? var.private_prefix_length - local.vpc_prefix_length : null
    public  = local.create_public ? var.public_prefix_length - local.vpc_prefix_length : null
  }
  private_azs       = local.create_private ? local.azs : []
  public_azs        = local.create_public ? local.azs : []
  vpc_prefix_length = substr(var.vpc_cidr_block, -2, 2)
}

resource "aws_subnet" "public" {
  for_each = toset(local.public_azs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.cidr_blocks["public"][each.value]
  availability_zone       = each.value
  map_public_ip_on_launch = true

  tags = merge(
    local.default_tags,
    { Name = "Public | ${local.vpc_resolved_tags["Name"]} | ${local.abbreviated_azs[each.value]}" },
    var.extra_tags,
    var.public_subnet_extra_tags
  )
}

resource "aws_subnet" "private" {
  for_each = toset(local.private_azs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.cidr_blocks["private"][each.value]
  availability_zone       = each.value
  map_public_ip_on_launch = false

  tags = merge(
    local.default_tags,
    { Name = "Private | ${local.vpc_resolved_tags["Name"]} | ${local.abbreviated_azs[each.value]}" },
    var.extra_tags,
    var.private_subnet_extra_tags
  )
}
