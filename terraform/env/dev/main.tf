terraform {
  required_version = "1.17.1"

  cloud {

    organization = "Techcare"

    workspaces {
      name = "serverless-provision"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "serverless_dev_infrastructure" {
  source = "../../blueprint"
}

# module "dev_infrastructure" {
#   source = "../../blueprint"
#   vpc_ipv4_primary_cidr_block   = "10.20.0.0/16"
#   vpc_instance_tenancy          = "default"
#   vpc_private_subnet_cidr_block = "10.20.1.0/24"
# }