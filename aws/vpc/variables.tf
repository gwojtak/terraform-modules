variable "enable_dns" {
  description = "Controls the `enable_dns_support` attribue of the VPC."
  type        = bool
  default     = true
}

variable "enable_hostnames" {
  description = "Controls the `enable_dns_hostnames` attribute of the VPC"
  type        = bool
  default     = true
}

variable "enable_ipv6" {
  description = "Allows control of enabling IPv6 in the VPC"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Identifier for the environment that this VPC supports"
  type        = string
  default     = null
}

variable "extra_tags" {
  description = "Allows passing in of tags to be applied to resources."
  type        = map(any)
  default     = {}
}

variable "name" {
  description = "A name to give to the VPC and associated resources"
  type        = string
}

variable "num_azs" {
  description = "The number of Availability Zones the VPC should span"
  type        = number
  default     = 3
}

variable "num_nat_gws" {
  description = "Number of NAT gateways to create (0=None, 1=One, >1=One Per AZ)"
  type        = number
  default     = 0
}

variable "private_prefix_length" {
  description = "Prefix length for the private subnet netmask.  Set to 0 to disable private subnets."
  type        = number
}

variable "public_prefix_length" {
  description = "Prefix length for the public subnet netmask.  Set to 0 to disable public subnets."
  type        = number
}

variable "vpc_cidr_block" {
  description = "CIDR block assigned to the VPC"
  type        = string
}
