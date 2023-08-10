terraform {
  required_version = ">=1.5.0"
  required_providers {
    aws = {
      version = ">=5.10"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      ManagedBy = "Terraform"
      Module    = "github.com/gwojtak/terraform-modules/aws/role"
    }
  }
}
