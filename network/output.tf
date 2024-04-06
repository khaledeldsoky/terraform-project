output "vpc_id" {
  value = aws_vpc.vpc_iti.id
}

output "subnet_public_id" {
  value = aws_subnet.subnet_public.id
}

output "subnet_private_id" {
  value = aws_subnet.subnet_private.id
}

output "vpc_cidr_block" {
  value = aws_vpc.vpc_iti.cidr_block
}
