variable "ipv4_primary_cidr_block" {
  description = <<-EOT
    "The primary IPv4 CIDR block for the VPC."
    Either `ipv4_primary_cidr_block` or `ipv6_cidr_block` must be specified. If both are specified, the VPC will have both an IPv4 and an IPv6 CIDR block.
    EOT
  type        = string
  default     = null
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC. Valid values are 'default' and 'dedicated'."
  type        = string
  default     = "default"
  #   validation {
  #     condition     = contains(["default", "dedicated", "host"], var.instance_tenancy)
  #     error_message = "Instance tenancy must be one of 'default', 'dedicated', or 'host'."
  #   }
}