resource "aws_internet_gateway" "getway" {
  vpc_id = aws_vpc.vpc_iti.id

  tags = {
    Name = "getway"
  }

}
