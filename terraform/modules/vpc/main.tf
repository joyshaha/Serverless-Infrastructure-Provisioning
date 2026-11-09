locals {
  ipv4_primary_cidr_block = var.ipv4_primary_cidr_block
  instance_tenancy        = var.instance_tenancy
}

resource "aws_vpc" "joyshaha_vpc" {
  cidr_block = local.ipv4_primary_cidr_block
  #   enable_dns_support   = true
  #   enable_dns_hostnames = true
  #   instance_tenancy     = "default"
  instance_tenancy = local.instance_tenancy
  tags = {
    Name = "joyshaha_vpc"
  }
}

resource "aws_internet_gateway" "joyshaha_igw" {
  vpc_id = aws_vpc.joyshaha_vpc.id
  tags = {
    Name = "joyshaha_igw"
  }
}