resource "aws_subnet" "subnet_public" {
  vpc_id            = aws_vpc.vpc_iti.id
  cidr_block        = var.subnet_public_cidr_block_var #"10.0.0.0/24"
  availability_zone = "${var.region_var}a"

  tags = {
    Name = "subnet_public"
  }

}





resource "aws_subnet" "subnet_private" {
  vpc_id            = aws_vpc.vpc_iti.id
  cidr_block        = var.subnet_private_cidr_block_var #"10.0.1.0/24"
  availability_zone = "${var.region_var}a"              #us-east-1a

  tags = {
    Name = "subnet_private"
  }

}


