variable "ami_type" {
  description = "The kind of AMI to run on the cluster nodes."
  type        = string
  default     = "BOTTLEROCKET_x86_64"
}
variable "cluster_name" {
  description = "The name of the cluster to attach this node group to."
  type        = string
}

variable "desired_size" {
  description = "The desired number of nodes to be launched in the node group."
  type        = number
  default     = 1
}

variable "disk_size" {
  description = "Sets the size of the disk (in GB) for the nodes to use."
  type        = number
  default     = null
}

variable "environment" {
  description = "The environment in which the EKS node group runs "
  type        = string
}

variable "extra_tags" {
  description = "A map of tags that should be applied to all created resources."
  type        = map(any)
  default     = {}
}

variable "group_name" {
  description = "A name to give to this node group."
  type        = string
  default     = null
}

variable "instance_types" {
  description = "A list of instance types that the node group can contain."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "key_name" {
  description = "An EC2 SSH key name for use with node access."
  type        = string
  default     = null
}

variable "labels" {
  description = "Kubernetes labels to apply to the nodes."
  type        = map(any)
  default     = {}
}

variable "max_size" {
  description = "The maximum number of nodes that should be launched within the node group."
  type        = number
}

variable "min_size" {
  description = "The minimum number of nodes that the node group can scale down to."
  type        = number
}

variable "remote_security_group_ids" {
  description = "A list of CIDRs to allow access to the node group members."
  type        = list(string)
}

variable "role_name" {
  description = "A name to give to the ARN created for the instance."
  type        = string
  default     = null
}

variable "use_spot_instances" {
  description = "Whether to use on-demand or spot instances."
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "A list of subnet IDs that the node group should use."
  type        = list(string)
}
