resource "aws_subnet" "subnets" {
  for_each = var.subnets
  vpc_id            = aws_vpc.vpc_iti.id
  cidr_block        = each.value["cidr_block"] #"10.0.0.0/24"
  availability_zone = "${each.value["AZ"]}"
  tags = {
    Name = "subnet_public ${var.module}"
  }
}

# resource "aws_subnet" "subnet_public" {
#   vpc_id            = aws_vpc.vpc_iti.id
#   cidr_block        = var.subnet_public_cidr_block_var #"10.0.0.0/24"
#   availability_zone = "${var.region_var}${var.zone}"
#   tags = {
#     Name = "subnet_public ${var.module}"
#   }
# }




# resource "aws_subnet" "subnet_private" {
#   vpc_id            = aws_vpc.vpc_iti.id
#   cidr_block        = var.subnet_private_cidr_block_var #"10.0.1.0/24"
#   availability_zone = "${var.region_var}${var.zone}"

#   tags = {
#     Name = "subnet_private ${var.module}"
#   }

# }

# resource "aws_subnet" "subnet_private" {
#   vpc_id            = aws_vpc.vpc_iti.id
#   cidr_block        = var.subnet_private_cidr_block_var #"10.0.1.0/24"
#   availability_zone = "${var.region_var}${var.zone}"

#   tags = {
#     Name = "subnet_private ${var.module}"
#   }

# }

