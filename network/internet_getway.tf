resource "aws_internet_gateway" "my_getway" {
  vpc_id = aws_vpc.vpc_iti.id

  tags = {
    Name = "my_getway"
  }

}
