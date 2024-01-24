variable "deletion_window" {
  description = "The number of days that a key will wait to be deleted after being scheduled."
  type        = number
  default     = 30

  validation {
    condition     = var.deletion_window >= 7 && var.deletion_window <= 30
    error_message = "The deletion_window variable should be an integer between 7 and 30 (inclusive)."
  }
}

variable "environment" {
  description = "The environment in which this key is used (dev, production, etc)."
  type        = string
}

variable "extra_tags" {
  description = "Tags to add to the resources in addition to the default module tags."
  type        = map(any)
  default     = {}
}

variable "key_alias" {
  description = "If set, create an alias to assign to the created key."
  type        = string
  default     = null
}

variable "key_description" {
  description = "A description to give to the created key."
  type        = string
  default     = null
}
