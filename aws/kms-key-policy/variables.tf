variable "kms_key_id" {
  description = "The ID, ARN, Alias, or Alias ARN of the key to attach the policy to."
  type        = string
}

variable "actions" {
  description = "A list of the KMS actions to allow for the given principals."
  type        = list(string)
}

variable "sid" {
  description = "The description to give to the policy (sets the SID)"
  type        = string
  default     = null
}

variable "effect" {
  description = "Whether to allow or deny the actions."
  type        = string
  default     = "Allow"
}

variable "principal_type" {
  description = "The type of the principal."
  type        = string
}

variable "principal_identifiers" {
  description = "The identifiers of the principals (ARNs, for example)."
  type        = list(string)
}

variable "conditions" {
  description = "A list of condition variables, packed as an object with attributes `test` and `values`"
  type = list(object({
    variable = string
    test     = string
    values   = list(string)
  }))
  default = []
}
