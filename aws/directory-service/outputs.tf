output "dc_ips" {
  description = "The IP addresses of the Domain Controllers (alias for dns_ips)"
  value       = aws_directory_service_directory.this.dns_ip_addresses
}

output "directory_id" {
  description = "ID of the created Directory Server or Connector"
  value       = aws_directory_service_directory.this.id
}

output "directory_type" {
  description = "The type of the created directory"
  value       = aws_directory_service_directory.this.type
}

output "dns_ips" {
  description = "The IP addresses of the DNS servers for the domain (alias for dc_ips)"
  value       = aws_directory_service_directory.this.dns_ip_addresses
}

output "domain" {
  description = "The domain name assigned to this Active Directory"
  value       = aws_directory_service_directory.this.name
}

output "netbios_name" {
  description = "The short NetBIOS name of the domain"
  value       = aws_directory_service_directory.this.short_name
}

output "sso_enabled" {
  description = "Whether SSO was enabled on the domain or not"
  value       = aws_directory_service_directory.this.enable_sso
}
