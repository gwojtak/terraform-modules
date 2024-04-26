variable "description" {
  description = "A short explanation of the use of the security group."
  type        = string
  default     = null
}

variable "environment" {
  description = "The tier of the environment this system runs in (e.g. dev, uat, prod)."
  type        = string
}

variable "extra_tags" {
  description = "A map of tags to apply to the security group resources in addition to the default tags."
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "The name to give to the security group."
  type        = string
}

variable "inbound_rules" {
  description = "A list of inbound access rules in the format of `PROTOCOL_PORT_SOURCE_COMMENT`.  `PORT` can take the format of a single port or a range (`START-END`).  `SOURCE` can be an IPv4 or IPv6 address, another security group id, or `self`."
  type        = list(string)
  default     = []
}

variable "outbound_rules" {
  description = "A list of outbound access rules in the format of `PROTOCOL_PORT_SOURCE_COMMENT`.  `PORT` can take the format of a single port or a range (`START-END`).  `SOURCE` can be an IPv4 or IPv6 address, another security group id, or `self`."
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "The ID of the VPC in which to create the security group."
  type        = string
  default     = null
}
