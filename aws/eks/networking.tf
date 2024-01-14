locals {
  remote_sg_id = var.remote_security_group_id != null ? var.remote_security_group_id : aws_security_group.remote[0].id
}

data "aws_subnet" "main" {
  id = var.subnet_ids[0]
}

resource "aws_security_group" "remote" {
  count = var.remote_security_group_id == null ? 1 : 0

  description = "Rules for controlling remote (inbound) access to the cluster for provided services."
  name        = "${var.cluster_name}-eks-remoteAccess-secgrp"
  vpc_id      = data.aws_subnet.main.vpc_id

  tags = merge({ Name = "${var.cluster_name}-eks-remoteAccess-secgrp" }, local.resolved_tags)
}

resource "aws_security_group_rule" "remote" {
  for_each = var.remote_security_group_id == null ? var.inbound_access_rules : {}

  cidr_blocks       = each.value["cidr_blocks"]
  description       = "Allow inbound access on port ${each.key}/${each.value["protocol"]}."
  from_port         = each.key
  protocol          = each.value["protocol"]
  security_group_id = aws_security_group.remote[0].id
  to_port           = each.key
  type              = "ingress"
}

resource "aws_security_group_rule" "remote_outbound" {
  count = var.remote_security_group_id == null ? 1 : 0

  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow outbound access everywhere."
  from_port         = 0
  protocol          = -1
  security_group_id = aws_security_group.remote[0].id
  to_port           = 65535
  type              = "egress"
}
