variable "ad_type" {
  description = "The type of directory to deploy - SimpleAD, MicrosoftAD, or ADConnector"
  type        = string
  validation {
    condition     = contains(["SimpleAD", "MicrosoftAD", "ADConnector"], var.ad_type)
    error_message = "The variable ad_type must be one of SimpleAD, MicrosoftAD, or ADConnector."
  }
}

variable "create_log_group" {
  description = "When true and log_group_name is set, create a new CloudWatch Log Group instead of using an existing one"
  type        = bool
  default     = false
}

variable "customer_dns_ips" {
  description = "If ad_type is ADConnector, the IP addresses of the domain to connect to"
  type        = list(string)
  default     = []
}

variable "customer_username" {
  description = "If ad_type is ADConnector, the username to connect to the directory with"
  type        = string
  default     = null
}

variable "description" {
  description = "A descriptive string to attach to the instance."
  type        = string
  default     = ""
}

variable "environment" {
  description = "Used to denote dev, prod, staging, etc."
  type        = string
  default     = null
}

variable "directory_size" {
  description = "Only when directory_type is SimpleAD or ADConnector - specify the size of the directory"
  type        = string
  default     = null
}

variable "domain" {
  description = "The fully qualified name for the directory."
  type        = string
}

variable "extra_tags" {
  description = "A map containing tags to apply to created resources"
  type        = map(any)
  default     = {}
}

variable "log_group_name" {
  description = "When set, send logs to this CloudWatch Logs Log Group.  Set create_log_group to true if you want to create the log group"
  type        = string
  default     = null
}

variable "num_dcs" {
  description = ""
  type        = number
  default     = 2
  validation {
    condition     = var.num_dcs >= 2
    error_message = "The number of Domain Controllers specified by num_dcs must be greater than or equal to 2."
  }
}

variable "password" {
  description = "For SimpleAD and MicrosoftAD type, the password to set for the Admin.  For ADConnector types, this is the password to connect to the domain with."
  type        = string
  sensitive   = true
}

variable "server_edition" {
  description = "For MicrosoftAD type, specify Standard or Enterprise version of Active Directory"
  type        = string
  default     = null
}

variable "short_name" {
  description = "The NetBIOS (short) name to give to the domain"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "A list of subnet IDs in which to deploy the directories network interfaces"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC to create the directory in"
  type        = string
}
