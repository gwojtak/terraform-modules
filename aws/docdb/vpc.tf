data "aws_subnet" "net" {
  id = var.subnet_ids[0]
}

resource "aws_security_group" "mongo" {
  description = "Security group for access to the ${var.cluster_name} DocumentDB cluster"
  name_prefix = "${var.cluster_name}-access"
  vpc_id      = data.aws_subnet.net.vpc_id

  tags = merge({ Name = "${var.cluster_name}-instance-sg" }, local.resolved_tags)
}

resource "aws_security_group_rule" "mongo" {
  for_each = toset(["ingress", "egress"])

  cidr_blocks       = each.value == "egress" ? ["0.0.0.0/0"] : var.inbound_cidrs
  type              = each.value
  protocol          = "TCP"
  from_port         = each.value == "egress" ? 0 : var.port
  to_port           = each.value == "egress" ? 65535 : var.port
  security_group_id = aws_security_group.mongo.id
}
