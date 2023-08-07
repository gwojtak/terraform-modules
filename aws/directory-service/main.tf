/**
 * # AWS Directory Service Module
 * 
 * Creates a AWS managed Active Directory or Connector
 *
 * TODO:
 * - domain trusts
 * - conditional forwarders
 * - regional replica
 * - shared directories
 * - log subscription
 */

terraform {
  required_version = "~> 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.10"
    }
  }
}
