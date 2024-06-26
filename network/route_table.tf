resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_iti.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_getway.id
  }

  tags = {
    Name = "route_table_public"
  }

}


resource "aws_route_table_association" "puclic_route_table_association" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.public_route_table.id
}

