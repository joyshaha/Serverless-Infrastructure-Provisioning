variable "vpc_ipv4_primary_cidr_block" {
  description = "The primary IPv4 CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_instance_tenancy" {
  description = "The instance tenancy option for the VPC."
  type        = string
  default     = "default"
}

variable "vpc_private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet."
  type        = string
  default     = "10.0.1.0/24"
}

# The root module connects
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}