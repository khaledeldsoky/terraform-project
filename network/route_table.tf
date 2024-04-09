resource "aws_route_table" "route_table" {
  for_each = var.route_table
  vpc_id   = aws_vpc.vpc_iti.id


  route {
    cidr_block = each.value.cidr_block
    gateway_id = each.value.gateway_id
  }
  tags = {
    Name = each.key
  }
}


resource "aws_route_table_association" "puclic_route_table_association" {
  for_each       = var.subnets
  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.route_table[each.value.route_table].id
}


