module "test_docdb" {
  source = "../"

  cluster_name                   = "test-cluster"
  cluster_type                   = "instance"
  db_cluster_parameters          = {}
  encryption_key                 = "arn:aws:kms:us-east-2:948931713791:key/41b5c62b-145e-4385-b523-b88c8bacd16b"
  encryption_key_deletion_window = 7
  extra_tags                     = {}
  inbound_cidrs                  = ["10.0.0.0/16"]
  num_instances                  = 2
  password                       = var.password
  port                           = 27017
  shard_capacity                 = 2
  shard_count                    = 1
  subnet_ids                     = ["subnet-08622075833e093c9", "subnet-019d242a7c7ca4595"]
  username                       = var.username
}
