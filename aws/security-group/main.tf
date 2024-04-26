locals {
  default_tags = {
    ManagedBy      = "Terraform"
    Environment    = var.environment
    ResourceModule = "github.com/gwojtak/terraform-modules//aws/security-group"
  }
  resolved_tags = merge(local.default_tags, var.extra_tags)
  other_inbound_rules = {
    for rule in var.inbound_rules :
    rule => {
      type             = "ingress"
      protocol         = split("_", rule)[0]
      from_port        = split("-", split("_", rule)[1])[0]
      to_port          = try(split("-", split("_", rule)[1])[1], split("-", split("_", rule)[1])[0])
      source_ipv4_cidr = can(regex("[0-9]\\.[0-9]{1,3}/[0-9]", split("_", rule)[2])) ? [split("_", rule)[2]] : null
      source_ipv6_cidr = can(regex(":", split("_", rule)[2])) ? [split("_", rule)[2]] : null
      source_secgrp_id = can(regex("^sg-", split("_", rule)[2])) ? split("_", rule)[2] : null
      description      = try(split("_", rule)[3], "")
    } if split("_", rule)[2] != "self"
  }
  self_inbound_rules = {
    for rule in var.inbound_rules :
    rule => {
      type        = "ingress"
      protocol    = split("_", rule)[0]
      from_port   = split("-", split("_", rule)[1])[0]
      to_port     = try(split("-", split("_", rule)[1])[1], split("-", split("_", rule)[1])[0])
      self        = true
      description = try(split("_", rule)[3], "")
    } if split("_", rule)[2] == "self"
  }
  other_outbound_rules = {
    for rule in var.outbound_rules :
    rule => {
      type             = "egress"
      protocol         = split("_", rule)[0]
      from_port        = split("-", split("_", rule)[1])[0]
      to_port          = try(split("-", split("_", rule)[1])[1], split("-", split("_", rule)[1])[0])
      source_ipv4_cidr = can(regex("[0-9]\\.[0-9]{1,3}/[0-9]", split("_", rule)[2])) ? [split("_", rule)[2]] : null
      source_ipv6_cidr = can(regex(":", split("_", rule)[2])) ? [split("_", rule)[2]] : null
      source_secgrp_id = can(regex("^sg-", split("_", rule)[2])) ? split("_", rule)[2] : null
      description      = try(split("_", rule)[3], "")
    } if split("_", rule)[2] != "self"
  }
  self_outbound_rules = {
    for rule in var.outbound_rules :
    rule => {
      type        = "egress"
      protocol    = split("_", rule)[0]
      from_port   = split("-", split("_", rule)[1])[0]
      to_port     = try(split("-", split("_", rule)[1])[1], split("-", split("_", rule)[1])[0])
      self        = true
      description = try(split("_", rule)[3], "")
    } if split("_", rule)[2] == "self"
  }
  self_rules  = merge(local.self_inbound_rules, local.self_outbound_rules)
  other_rules = merge(local.other_inbound_rules, local.other_outbound_rules)
}

resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge({ Name = var.name }, local.resolved_tags)
}

resource "aws_security_group_rule" "other" {
  for_each = toset(keys(local.other_rules))

  security_group_id = aws_security_group.this.id
  type              = local.other_rules[each.value].type

  protocol                 = local.other_rules[each.value].protocol
  from_port                = local.other_rules[each.value].from_port
  to_port                  = local.other_rules[each.value].to_port
  cidr_blocks              = local.other_rules[each.value].source_ipv4_cidr
  ipv6_cidr_blocks         = local.other_rules[each.value].source_ipv6_cidr
  source_security_group_id = local.other_rules[each.value].source_secgrp_id
  description              = local.other_rules[each.value].description
}

resource "aws_security_group_rule" "self" {
  for_each = toset(keys(local.self_rules))

  security_group_id = aws_security_group.this.id
  type              = local.self_rules[each.value].type

  protocol    = local.self_rules[each.value].protocol
  from_port   = local.self_rules[each.value].from_port
  to_port     = local.self_rules[each.value].to_port
  description = local.self_rules[each.value].description
  self        = true
}
