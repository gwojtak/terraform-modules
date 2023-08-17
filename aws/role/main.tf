terraform {
  required_version = ">=1.5.0"
  required_providers {
    aws = {
      version = ">=5.10"
      source  = "hashicorp/aws"
    }
  }
}

locals {
  default_tags = {
    ManagedBy      = "Terraform"
    ResourceModule = "github.com/gwojtak/terraform-modules//aws/role"
  }
}
