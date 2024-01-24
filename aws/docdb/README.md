<!-- BEGIN TERRAFORM-DOCS -->
# Amazon DocumentDB Module

Creates a DocumentDB cluster or elastic cluster

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.32.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.32.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_docdb_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster) | resource |
| [aws_docdb_cluster_instance.these](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_instance) | resource |
| [aws_docdb_cluster_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_parameter_group) | resource |
| [aws_docdb_subnet_group.that](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_subnet_group) | resource |
| [aws_docdbelastic_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdbelastic_cluster) | resource |
| [aws_kms_key.encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_security_group.mongo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.mongo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.net](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name that identifies the DocumentDB cluster | `string` | n/a | yes |
| <a name="input_cluster_type"></a> [cluster\_type](#input\_cluster\_type) | Controls whether to deploy an instance-based or elastic cluster.  Valid values are `instance` or `elastic` | `string` | `"instance"` | no |
| <a name="input_db_cluster_parameters"></a> [db\_cluster\_parameters](#input\_db\_cluster\_parameters) | A map of key/value pairs describing documentdb parameters for the parameter group.  Se the [Amazon DocumentDB Docs](https://docs.aws.amazon.com/documentdb/latest/developerguide/cluster_parameter_groups-list_of_parameters.html) for valid options. | `map(any)` | `{}` | no |
| <a name="input_encryption_key"></a> [encryption\_key](#input\_encryption\_key) | To enable encryption, this is a KMS key ID, or "CMK" to create a new dedicated key, or null to disable encryption | `string` | `null` | no |
| <a name="input_encryption_key_deletion_window"></a> [encryption\_key\_deletion\_window](#input\_encryption\_key\_deletion\_window) | The number of days to wait before deleting the KMS key after requesting deletion.  Should be a value between 7-30 | `number` | `30` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | A mapping of key/value pairs to be applied to all resources created in this module | `map(any)` | `{}` | no |
| <a name="input_inbound_cidrs"></a> [inbound\_cidrs](#input\_inbound\_cidrs) | A list of security group IDs to apply to the created cluster | `list(string)` | n/a | yes |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | The class of instance that the DocumentDB should run on. | `string` | `"db.t3.medium"` | no |
| <a name="input_num_instances"></a> [num\_instances](#input\_num\_instances) | The number of instances to deploy for a standard (non-elastic) cluster | `number` | `2` | no |
| <a name="input_password"></a> [password](#input\_password) | Sets the master password for the cluster | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | The TCP port that the cluster listens on | `number` | `27017` | no |
| <a name="input_shard_capacity"></a> [shard\_capacity](#input\_shard\_capacity) | The number of vCPUs assigned to each cluster shard. | `number` | `0` | no |
| <a name="input_shard_count"></a> [shard\_count](#input\_shard\_count) | The number of shards assigned to the cluster. | `number` | `0` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The IDs of the subnets to deploy the cluster to. | `list(string)` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Sets the master username for the cluster | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the created DocumentDB (elastic or instance) cluster. |
| <a name="output_cluster_instance_ids"></a> [cluster\_instance\_ids](#output\_cluster\_instance\_ids) | The ID of the instances making up an instance-based cluster. |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | The ARN of the KMS key that was created if `kms_key_id` was "CMK" |
| <a name="output_parameter_group_id"></a> [parameter\_group\_id](#output\_parameter\_group\_id) | The ID of the cluster parameter group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group created for controlling DocumentDB access. |
| <a name="output_subnet_group_id"></a> [subnet\_group\_id](#output\_subnet\_group\_id) | The ID of the cluster's subnet group |
<!-- END TERRAFORM-DOCS -->