terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  profile = "metis"
}

module "test" {
  source = "../"

  cluster_addons = [{
    name                = "kube-proxy"
    version             = "v1.28.1-eksbuild.1"
    service_account_arn = null
    configuration       = {}
    },
    {
      name                = "coredns"
      version             = "v1.10.1-eksbuild.2"
      service_account_arn = null
      configuration       = {}
    },
    {
      name                = "vpc-cni"
      version             = "v1.14.1-eksbuild.1"
      service_account_arn = null
      configuration       = {}
    }
  ]


  cluster_name = "test-eks"
  subnet_ids   = ["subnet-08622075833e093c9", "subnet-019d242a7c7ca4595"]
  environment  = "dev"
  inbound_access_rules = {
    "80" = {
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

output "test" {
  value = module.test
}
