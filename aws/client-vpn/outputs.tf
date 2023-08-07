output "client_vpn_id" {
  description = "The ID of the created client VPN endpoint"
  value       = aws_ec2_client_vpn_endpoint.this.id
}

output "client_cidr_block" {
  description = "The created endpoint's CIDR block"
  value       = aws_ec2_client_vpn_endpoint.this.client_cidr_block
}

output "dns_servers" {
  description = "A list of the DNS servers that the clients will use when connected to VPN"
  value       = aws_ec2_client_vpn_endpoint.this.dns_servers
}

output "protocol" {
  description = "VPN can run on either UDP or TCP, this tells what the endpoint uses"
  value       = aws_ec2_client_vpn_endpoint.this.transport_protocol
}

output "port" {
  description = "The port (443 or 1194) on which the VPN runs"
  value       = aws_ec2_client_vpn_endpoint.this.vpn_port
}

output "allow_all_authorization_rules" {
  description = "The VPN authorization rules that allow all regardless of groups"
  value       = aws_ec2_client_vpn_authorization_rule.all
}

output "groups_authorization_rules" {
  description = "The VPN authorization rules that allow based on group membership in the directory"
  value       = aws_ec2_client_vpn_authorization_rule.groups
}

output "routes" {
  description = "All client routes configured for this endpoint"
  value       = aws_ec2_client_vpn_route.these
}

output "self_service_portal" {
  description = "The URL of the Self-Service Portal for this VPN endpoint"
  value       = var.enable_self_service_portal ? "https://self-service.clientvpn.amazonaws.com/endpoints/${aws_ec2_client_vpn_endpoint.this.id}" : null
}
