output "vpc_id" {
  description = "The id of the created vpc"
  value = aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the vpc"
  value = aws_vpc.this.cidr_block
}

output "subnet_ids" {
  description = "A map of public and private subnet ids"
  value = {
    public  = { for az in local.azs : az => aws_subnet.public[az].id }
    private = { for az in local.azs : az => aws_subnet.private[az].id }
  }
}

output "subnet_cidrs" {
  description = "A map of public and private subnet CIDR blocks"
  value = {
    public  = { for az in local.azs : az => aws_subnet.public[az].cidr_block }
    private = { for az in local.azs : az => aws_subnet.private[az].cidr_block }
  }
}

output "availability_zones" {
  description = "A list of the availability zones the VPC spans"
  value = local.azs
}

output "route_table_ids" {
  description = "A map of public and private route table ids"
  value = {
    public = [aws_route_table.public.id]
    private = [ for r in aws_route_table.private : r.id ]
  }
}
