variable "encryption_key" {
  description = "If the repository should use encryption, this should be the KMS key ID or the value `AES256`."
  type        = string
  default     = null

  validation {
    condition     = var.encryption_key == null || var.encryption_key == "AES256" || can(regex("^arn:aws:kms:.*:[0-9]{12}:key/.+$", var.encryption_key))
    error_message = "The `encryption_key` variable should be either set to `null`, `AES256`, or the ARN of an existing KMS key."
  }
}

variable "environment" {
  description = "The name of the environment for created resources, ie `dev` or `prod`."
  type        = string
}

variable "extra_tags" {
  description = "A map of extra tags to apply to all created resources."
  type        = map(string)
  default     = {}
}

variable "immutable_tags" {
  description = "Whether tag immutability should be set or not."
  type        = bool
  default     = false
}

variable "name" {
  description = "The name of the ECR repository."
  type        = string
}

variable "scan_image_on_push" {
  description = "Sets the action to scan images as they are pushed automatically."
  type        = bool
  default     = false
}
