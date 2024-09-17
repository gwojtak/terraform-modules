variable "auth_type" {
  description = "The methods to control EKS cluster access."
  type        = string
}

variable "bootstrap_access" {
  description = "Whether to bootstrap the EKS cluster access."
  type        = bool
  default     = true
}

variable "bootstrap_default_addons" {
  description = "Controls creation of default addons, such as aws-cni, kube-prox, and CoreDNS."
  type        = bool
  default     = true
}

variable "cluster_addons" {
  description = "A list of EKS add-ons to request be installed."
  type = list(object({
    name                = string
    version             = string
    configuration       = string
    service_account_arn = string
    })
  )
  default = []
}

variable "cluster_log_types" {
  description = "A list of logging types to enable on the cluster."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for i in var.cluster_log_types : contains(["api", "audit", "authenticator", "controllerManager", "scheduler"], i)]) || var.cluster_log_types == []
    error_message = "The variable `cluster_log_types` should be a list containing 0 or more of the strings `api`, `audit`, `authenticator`, `coltrollerManager`, or `scheduler`."
  }
}

variable "cluster_name" {
  description = "A name to give to the EKS cluster."
  type        = string
}

variable "cluster_role_name" {
  description = "A name to give to the cluster role."
  type        = string
  default     = null
}

variable "encryption_key" {
  description = "The ARN of a KMS key to use for encryption.  Alternately, the value `CMK`, indicating this module should create and manage a key.  `null` for no encryption (not recommended)."
  type        = string
  default     = "CMK"
}

variable "environment" {
  description = "The name of the environment that the cluster is a part of (dev, test, prod)."
  type        = string
}

variable "extra_tags" {
  description = "A map representing tags to apply to all resources created with this module."
  type        = map(any)
  default     = {}
}

variable "inbound_access_rules" {
  description = "A list of maps defining allowed incoming connection by port, protocol, and cidr block"
  type        = map(any)
}

variable "kubernetes_version" {
  description = "Desired Kubernetes master version.  A null value tells EKS to use the latest version at creation time."
  type        = string
  default     = null
}

variable "public_access_cidrs" {
  description = "Provides a list of CIDRs for public IP address.  If the list is a null value, public access will be disabled all together."
  type        = list(string)
  default     = []
}

variable "private_endpoint_enabled" {
  description = "Controls whether to enable or disable Control Plane access from within the VPC."
  type        = bool
  default     = true
}

variable "remote_security_group_id" {
  description = "The ID of the existing remote access security group to use, or null to create one."
  type        = string
  default     = null
}

variable "service_cidr" {
  description = "The IPv4 CIDR block for the EKS cluster pod and service IP address allocation."
  type        = string
  default     = "172.20.0.0/16"
}

variable "subnet_ids" {
  description = "A list of subnet ids to place the cluster nodes into."
  type        = list(string)
}
