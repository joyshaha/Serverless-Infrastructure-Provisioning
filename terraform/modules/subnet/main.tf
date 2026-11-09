locals {
  vpc_id                    = var.vpc_id
  private_subnet_cidr_block = var.private_subnet_cidr_block
}

resource "aws_subnet" "joyshaha_private_subnet" {
  vpc_id            = local.vpc_id
  cidr_block        = local.private_subnet_cidr_block
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "joyshaha_private_subnet"
  }
}