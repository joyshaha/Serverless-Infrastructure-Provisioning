variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  default     = "vpc-12345678"
}

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.0.1.0/24"
}