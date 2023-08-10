variable "create_instance_profile" {
  description = "Controls whether to create an instance profile the the created role attached to it."
  type        = bool
  default     = false
}

variable "extra_tags" {
  description = "Any tags to assign to all created resources can be passed in here."
  type        = map(any)
  default     = {}
}

variable "policy_description" {
  description = "Attach this description to the created policy."
  type        = string
}

variable "policy_document" {
  description = "A string representing the JSON policy document.  Can be created with `aws_iam_policy_document` data source or `jsonencode()` function."
  type        = string
}

variable "role_description" {
  description = "Attach this description to the created role."
  type        = string
}

variable "role_name" {
  description = "This is the name of the created IAM role.  The name of the policy and optional instance profile are based off of this value."
  type        = string
}

variable "role_trust_canonicals" {
  description = "A list of AWS CannonicalUser IDs that should be added to the role's trust policy.  Can be a list of CanonicalUser IDs or `*`."
  type        = list(string)
  default     = []
}

variable "role_trust_federated" {
  description = "A list of web identity users or SAML provider ARNs that should be added to the role's trust policy.  Can be a list with a single element, `*`."
  type        = list(string)
  default     = []
}

variable "role_trust_principals" {
  description = "A list of AWS ARNs that should be added to the role's trust policy.  Can be a list with a single element, `*`."
  type        = list(string)
  default     = []
}

variable "role_trust_services" {
  description = "A list of AWS Service roles that should be added to the role's trust policy.  Can be a list with a single element, `*`."
  type        = list(string)
  default     = []
}
