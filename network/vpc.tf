resource "aws_vpc" "vpc_iti" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "iti_vpc"
  }
}

