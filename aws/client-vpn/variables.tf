variable "auth_certificate_arn" {
  description = "If set, use this certificate for client authentication"
  type        = string
  default     = null
}

variable "auth_directory_id" {
  description = "If set, use this Active Directory for client authentication"
  type        = string
  default     = null
}

variable "auth_saml_arn" {
  description = "If set, use this SAML provider for client authentication"
  type        = string
  default     = null
}

variable "authorization_rules" {
  description = "An map of authorization rules for target subnets and group.  Use ALL if authorization by group is not desired or applicable"
  type = list(object(
    {
      authorize   = string
      cidr        = string
      description = string
    }
  ))
}

variable "certificate_arn" {
  description = "The ARN of the certificate to use for the server connection.  If not specified, a new one will be created."
  type        = string
}

variable "client_cidr" {
  description = "The IP address range for client machines"
  type        = string
  default     = "10.255.0.0/23"
}

variable "cloudwatch_log_group" {
  description = "A name to give to the cloudwatch log group.  If empty, don't use cloudwatch logs"
  type        = string
  default     = null
}

variable "cloudwatch_log_stream" {
  description = "A name to give to the cloudwatch log stream."
  type        = string
  default     = null
}

variable "description" {
  description = "Descriptive text to assign to the description field for the VPN client connection"
  type        = string
  default     = ""
}

variable "dns_servers" {
  description = "Force VPN clients to use these DNS servers.  Defaults to the VPC DNS server."
  type        = list(string)
  default     = []
}

variable "enable_split_tunnel" {
  description = "Controls whether all traffic should flow through VPN or only specific routes"
  type        = bool
  default     = true
}

variable "enable_self_service_portal" {
  description = "Controls whether the VPN Endpoint's self-service portal should be enabled or disabled"
  type        = bool
  default     = false
}

variable "extra_tags" {
  description = "Any extra tags to assign to these resources"
  type        = map(string)
  default     = {}
}

variable "login_banner" {
  description = "The text of the login banner to display upon client connection"
  type        = string
  default     = null
}

variable "port" {
  description = "The port for the VPN connection to use"
  type        = number
  default     = 1194
}

variable "protocol" {
  description = "Select UDP or TCP for the VPN protocol"
  type        = string
  default     = "udp"
}

variable "routes" {
  description = "A map that defines target networks and the gateway to them"
  type = list(object(
    {
      description = string
      to          = string
      via         = string
    }
  ))
}

variable "self_service_saml_provider_arn" {
  description = "TRhe ARN of the IAM SAML identity provider for the self service portal if type is federated-authentication."
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "A list of security groups to assign to the target network"
  type        = list(string)
  default     = null
}

variable "subnet_id_associations" {
  description = "The subnet IDs that the VPN endpoint should be associated with"
  type        = list(string)
}

variable "vpc_id" {
  description = "The id of the VPC to create the client vpn connection into"
  type        = string
  default     = null
}
