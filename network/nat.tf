resource "aws_nat_gateway" "nat_ec2_private" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.subnet_private.id

  tags = {
    Name = "gw NAT"
  }

}


resource "aws_eip" "elastic_ip" {
  domain = "vpc"
  
    tags = {
    Name = "elastic ip"
  }

}

















