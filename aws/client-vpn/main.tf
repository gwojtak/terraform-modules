/**
 * # AWS Client VPN Endpoint Module
 * 
 * Creates a Client VPN Endpoint
 *
 * Suports
 * - Different authorization types
 * - Authorization rules
 * - Routes
 * - Split tunnels
 * - Custom DNS Server serttings
 *
 */

locals {
  all_authorization_rules    = [for rule in var.authorization_rules : rule if rule.authorize == "ALL"]
  auth_type                  = var.auth_certificate_arn != null ? "certificate-authentication" : var.auth_directory_id != null ? "directory-service-authentication" : var.auth_saml_arn != null ? "federated-authentication" : null
  dns_servers                = length(var.dns_servers) >= 1 ? var.dns_servers : [cidrhost(data.aws_vpc.this.cidr_block, 2)]
  enable_connection_logs     = var.cloudwatch_log_group != null
  enable_banner              = var.login_banner != null
  groups_authorization_rules = [for rule in var.authorization_rules : rule if rule.authorize != "ALL"]
  self_service_portal        = var.enable_self_service_portal ? "enabled" : "disabled"
  use_auth_certificate       = var.auth_certificate_arn != null ? true : false
  use_auth_directory         = var.auth_directory_id != null ? true : false
  use_auth_saml              = var.auth_saml_arn != null ? true : false

  root_certificate_chain_arn     = local.use_auth_certificate ? var.auth_certificate_arn : null
  active_directory_id            = local.use_auth_directory ? var.auth_directory_id : null
  saml_identity_provider_id      = local.use_auth_saml ? var.auth_saml_arn : null
  self_service_saml_provider_arn = local.use_auth_saml ? var.self_service_saml_provider_arn : null

  resolved_tags = merge({ ManagedBy = "Terraform" }, var.extra_tags)
}

data "aws_vpc" "this" {
  id = var.vpc_id
}

resource "aws_ec2_client_vpn_endpoint" "this" {
  client_cidr_block      = var.client_cidr
  description            = var.description
  dns_servers            = local.dns_servers
  security_group_ids     = var.security_group_ids
  self_service_portal    = local.self_service_portal
  server_certificate_arn = var.certificate_arn
  split_tunnel           = var.enable_split_tunnel
  transport_protocol     = var.protocol
  vpc_id                 = var.vpc_id
  vpn_port               = var.port

  connection_log_options {
    enabled               = local.enable_connection_logs
    cloudwatch_log_group  = var.cloudwatch_log_group
    cloudwatch_log_stream = var.cloudwatch_log_stream
  }

  authentication_options {
    type                           = local.auth_type
    active_directory_id            = local.active_directory_id
    root_certificate_chain_arn     = local.root_certificate_chain_arn
    saml_provider_arn              = local.saml_identity_provider_id
    self_service_saml_provider_arn = local.self_service_saml_provider_arn
  }

  client_login_banner_options {
    enabled     = local.enable_banner
    banner_text = var.login_banner
  }

  tags = local.resolved_tags

  lifecycle {
    precondition {
      condition     = !(var.auth_directory_id != null && var.auth_saml_arn != null && var.auth_certificate_arn != null)
      error_message = "Only one or neither directory-type auth method can be specified, not both."
    }

    precondition {
      condition     = (var.security_group_ids != null && var.vpc_id == null) || var.security_group_ids == null
      error_message = "Specifying security group IDs requires that vpc_id be set."
    }
  }
}

resource "aws_ec2_client_vpn_network_association" "these" {
  for_each = toset(var.subnet_id_associations)

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  subnet_id              = each.value
}

resource "aws_ec2_client_vpn_authorization_rule" "all" {
  for_each = { for index, rule in local.all_authorization_rules :
    rule.cidr => rule
  }

  authorize_all_groups   = true
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  description            = each.value.description
  target_network_cidr    = each.value.cidr
}

resource "aws_ec2_client_vpn_authorization_rule" "groups" {
  for_each = { for index, rule in local.groups_authorization_rules :
    rule.cidr => rule
  }

  access_group_id        = each.value.authorize
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  description            = each.value.description
  target_network_cidr    = each.value.cidr
}

resource "aws_ec2_client_vpn_route" "these" {
  for_each = { for index, route in var.routes :
    route.to => route
  }

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  description            = each.value.description
  destination_cidr_block = each.value.to
  target_vpc_subnet_id   = each.value.via
}
