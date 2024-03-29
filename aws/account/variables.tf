variable "admin_username" {
  description = "The username for the account administrator to create."
  type        = string
  default     = "AccountAdmin"
}

variable "admin_user_path" {
  description = "Set this if you want to place the account admin user in a different ARN path."
  type        = string
  default     = "/"
}

variable "admin_group_name" {
  description = "The name to give the acount administrator group."
  type        = string
  default     = "AccountAdmins"
}

variable "admin_group_path" {
  description = "Set this if you want to place the account admin group in a different ARN path."
  type        = string
  default     = "/"
}

variable "admin_password_length" {
  description = "Sets the length of the generated password."
  type        = number
  default     = null
}

variable "alias" {
  description = "The name of the account alias to assign."
  type        = string
  default     = null
}

variable "allow_user_password_change" {
  description = "Controls whether users are able to change their own passwords."
  type        = bool
  default     = null
}

variable "extra_tags" {
  description = "A map of tags to apply to all resources created that support them."
  type        = map(string)
  default     = {}
}

variable "hard_expiry" {
  description = "Controls whether or not users are explicitly prevented from setting a new password after it expires."
  type        = bool
  default     = null
}

variable "max_password_age" {
  description = "If set, prevents reusing passwords the specified number of times."
  type        = number
  default     = null
}

variable "min_password_length" {
  description = "The minimum number of characters IAM users' passwords should be."
  type        = number
  default     = null
}

variable "password_reuse_count" {
  description = "The number of passwords that must be used before being able to reuse them again."
  type        = number
  default     = null
}

variable "permissions_boundary" {
  description = "The ARN or name of a policy to act as a permissions boundary for the created account administrator user."
  type        = string
  default     = null
}

variable "pgp_key" {
  description = "A PGP key or keybase id (in the format `keybase:username`) to encrypt the generated Admin password."
  type        = string
  default     = null
}

variable "require_password_change" {
  description = "Set to true to force Admin user to change the password on first login."
  type        = bool
  default     = true
}

variable "required_character_sets" {
  description = "A list of required character sets to apply to the password policy."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for item in var.required_character_sets : contains(["uppercase", "lowercase", "numbers", "symbols"], item)]) || var.required_character_sets == []
    error_message = "The variable `required_character_sets` should be a list with zero or more values of `uppercase`, `lowercase`, `numbers`, `symbols`."
  }
}

variable "root_mfa_name" {
  description = "The name to give to the virtual MFA device created for root."
  type        = string
  default     = "RootVirtualMFA"
}

variable "saml_metadata" {
  description = "A map of SAML metadata documents generated by identity providers to create a SAML 2.0 provider.  The key is the name of the provider, the value is the metadata document."
  type        = map(string)
  default     = {}
}
