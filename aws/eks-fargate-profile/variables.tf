variable "cluster_name" {
  description = "The name of the cluster for this Fargate profile."
  type        = string
}

variable "environment" {
  description = "The name of the environment this EKS profile is for."
  type        = string
}

variable "extra_tags" {
  description = "A list of tags to apply to all resources created with this module."
  type        = map(any)
}

variable "kubernetes_labels" {
  description = "A mapping of extra kubernetes labels to apply to the profile."
  type        = map(any)
  default     = {}
}

variable "namespace" {
  description = "Kubernetes namespace for description"
  type        = string
  default     = ""
}

variable "profile_name" {
  description = "The name to give to the created Fargate profile."
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet ids that the fargate instances will use to run pods."
  type        = list(string)
}
