terraform {
  required_version = ">= 1.5"
}

provider "aws" {
  region  = "us-east-2"
  profile = "metis"
}

data "aws_iam_policy_document" "t" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}

module "test" {
  source = "../"

  create_instance_profile = var.create_instance_profile
  extra_tags              = var.extra_tags
  managed_policy_names    = ["AdministratorAccess"]
  policy_description      = var.policy_description
  policy_document         = data.aws_iam_policy_document.t.json
  role_description        = var.role_description
  role_name               = var.role_name
  role_trust_services     = ["ec2.amazonaws.com"]
}

output "test" {
  value = module.test
}
