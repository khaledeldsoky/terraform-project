output "vpc_id" {
  value = aws_vpc.vpc_iti.id
}

output "subnet_id" {
  value = { for subnet in aws_subnet.subnets : subnet.tags_all["Name"] => subnet.id }
}


output "vpc_cidr_block" {
  value = aws_vpc.vpc_iti.cidr_block
}

output "nat_id" {
  value = aws_nat_gateway.nat.id
}

output "gatway_id" {
  value = aws_internet_gateway.getway.id
}