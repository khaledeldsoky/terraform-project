#------------ screts var ------------#
variable "vpc_cidr_block" {
  type = string
}
variable "region" {
  type = string
}
#------------ network var ------------#

#------------ network var ------------#


variable "subnet_public_cidr_block" {
  type = string
}

variable "subnet_private_cidr_block" {
  type = string
}

variable "ami_ubuntu" {
  type = string
}
variable "instance_type_t2_micro" {
  type = string
}
