resource "aws_vpc" "vpc_iti" {
  cidr_block           = var.iti_vpc_cidr_block_var
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "iti_vpc"
  }
}

