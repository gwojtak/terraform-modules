variable "cluster_name" {
  description = "The name that identifies the DocumentDB cluster"
  type        = string
}

variable "cluster_type" {
  description = "Controls whether to deploy an instance-based or elastic cluster.  Valid values are `instance` or `elastic`"
  type        = string
  default     = "instance"
  validation {
    condition     = var.cluster_type == "instance" || var.cluster_type == "elastic"
    error_message = "The variable `cluster_type` needs to have a value of `instance` or `elastic`."
  }
}

variable "db_cluster_parameters" {
  description = "A map of key/value pairs describing documentdb parameters for the parameter group.  Se the [Amazon DocumentDB Docs](https://docs.aws.amazon.com/documentdb/latest/developerguide/cluster_parameter_groups-list_of_parameters.html) for valid options."
  type        = map(any)
  default     = {}
}

variable "encryption_key" {
  description = "To enable encryption, this is a KMS key ID, or \"CMK\" to create a new dedicated key, or null to disable encryption"
  type        = string
  default     = null
}

variable "encryption_key_deletion_window" {
  description = "The number of days to wait before deleting the KMS key after requesting deletion.  Should be a value between 7-30"
  type        = number
  default     = 30
}

variable "extra_tags" {
  description = "A mapping of key/value pairs to be applied to all resources created in this module"
  type        = map(any)
  default     = {}
}

variable "inbound_cidrs" {
  description = "A list of security group IDs to apply to the created cluster"
  type        = list(string)
}

variable "instance_size" {
  description = "The class of instance that the DocumentDB should run on."
  type        = string
  default     = "db.t3.medium"
}

variable "num_instances" {
  description = "The number of instances to deploy for a standard (non-elastic) cluster"
  type        = number
  default     = 2
}

variable "password" {
  description = "Sets the master password for the cluster"
  type        = string
}

variable "port" {
  description = "The TCP port that the cluster listens on"
  type        = number
  default     = 27017
}

variable "shard_capacity" {
  description = "The number of vCPUs assigned to each cluster shard."
  type        = number
  default     = 0
  validation {
    condition     = contains([0, 2, 4, 8, 16, 32, 64], var.shard_capacity)
    error_message = "The variable `shard_capacity` should be a number in the set (2, 4, 8, 16, 32, 64)."
  }
}

variable "shard_count" {
  description = "The number of shards assigned to the cluster."
  type        = number
  default     = 0
  validation {
    condition     = var.shard_count <= 32 && var.shard_count >= 0
    error_message = "The variable `shard_count` needs to be less than or equal to 32."
  }
}

variable "subnet_ids" {
  description = "The IDs of the subnets to deploy the cluster to."
  type        = list(string)
}

variable "username" {
  description = "Sets the master username for the cluster"
  type        = string
}
