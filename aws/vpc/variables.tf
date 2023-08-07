variable "vpc_cidr_block" {
  description = "CIDR block assigned to the VPC"
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

variable "name" {
  description = "A name to give to the VPC and associated resources"
  type        = string
}

variable "environment" {
  description = "Identifier for the environment that this VPC supports"
  type        = string
  default     = ""
}

variable "public_mask_bits" {
  description = "Number of bits for the public subnet netmask"
  type        = number
}

variable "private_mask_bits" {
  description = "Number of bits for the private subnet netmask"
  type        = number
}

variable "enable_ipv6" {
  description = "Allows control of enabling IPv6 in the VPC"
  type        = bool
  default     = false
}
