locals {
  common_tags = {
    ManagedBy = "Terraform"
    Module    = "https://github.com/gwojtak/terraform-modules/aws/docdb"
  }
  resolved_tags  = merge(local.common_tags, var.extra_tags)
  encryption_key = var.encryption_key == "CMK" ? aws_kms_key.encryption[0].arn : var.encryption_key
  default_parameter_group_values = {
    audit_logs                           = "disabled"
    change_stream_log_retention_duration = 10800
    profiler                             = "disabled"
    profiler_sampling_rate               = "1.0"
    profiler_threshold_ms                = 100
    tls                                  = "enabled"
    ttl_monitor                          = "enabled"
  }
  parameter_group_values = merge(local.default_parameter_group_values, var.db_cluster_parameters)
}

resource "aws_kms_key" "encryption" {
  count = var.encryption_key == "CMK" ? 1 : 0

  description             = "Data encryption key for ${var.cluster_name}"
  deletion_window_in_days = var.encryption_key_deletion_window

  tags = merge({ Name = "${var.cluster_name}-encryption-key" }, local.resolved_tags)
}

resource "aws_docdbelastic_cluster" "main" {
  count = var.cluster_type == "elastic" ? 1 : 0

  auth_type              = "PLAIN_TEXT"
  admin_user_name        = var.username
  admin_user_password    = var.password
  kms_key_id             = local.encryption_key
  name                   = var.cluster_name
  shard_capacity         = var.shard_capacity
  shard_count            = var.shard_count
  subnet_ids             = var.subnet_ids
  vpc_security_group_ids = [aws_security_group.mongo.id]

  tags = merge({ Name = var.cluster_name }, local.resolved_tags)
}

resource "aws_docdb_cluster" "main" {
  count = var.cluster_type == "instance" ? 1 : 0

  allow_major_version_upgrade     = true
  cluster_identifier              = var.cluster_name
  db_subnet_group_name            = aws_docdb_subnet_group.that.name
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.this.name
  deletion_protection             = false
  engine                          = "docdb"
  kms_key_id                      = local.encryption_key
  master_username                 = var.username
  master_password                 = var.password
  port                            = var.port
  skip_final_snapshot             = true
  storage_encrypted               = true
  vpc_security_group_ids          = [aws_security_group.mongo.id]

  tags = merge({ Name = var.cluster_name }, local.resolved_tags)
}

resource "aws_docdb_cluster_instance" "these" {
  count = var.cluster_type == "instance" ? var.num_instances : 0

  identifier         = "${var.cluster_name}-docdb-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.main[0].id
  instance_class     = var.instance_size

  tags = merge(local.resolved_tags, { Name = "${var.cluster_name}-docdb-instance-${count.index}" })
}

resource "aws_docdb_cluster_parameter_group" "this" {
  description = "Parameter group for the ${var.cluster_name} DocDB cluster"
  family      = "docdb5.0"
  name        = "${var.cluster_name}-parameter-group"

  dynamic "parameter" {
    for_each = var.db_cluster_parameters

    content {
      name         = parameter.key
      value        = parameter.value
      apply_method = "immediate"
    }
  }

  tags = merge({ Name = "${var.cluster_name}-parameter-group" }, local.resolved_tags)
}

resource "aws_docdb_subnet_group" "that" {
  name        = "${var.cluster_name}-subnet-group"
  description = "DocumentDB subnet group for ${var.cluster_name} cluster"
  subnet_ids  = var.subnet_ids

  tags = merge({ Name = "${var.cluster_name}-subnet-group" }, local.resolved_tags)
}
