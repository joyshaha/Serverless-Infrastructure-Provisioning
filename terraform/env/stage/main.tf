terraform {
  required_version = "1.15.8"

  cloud {

    organization = "JoyShaha"

    workspaces {
      name = "module_iac_stage"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.53.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "prod_infrastructure" {
  source                        = "../../blueprint"
  vpc_ipv4_primary_cidr_block   = "10.10.0.0/16"
  vpc_instance_tenancy          = "default"
  vpc_private_subnet_cidr_block = "10.10.1.0/24"
}