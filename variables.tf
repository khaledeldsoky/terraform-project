#------------ screts var ------------#
variable "vpc_cidr_block" {
  type = string
}
variable "region" {
  type = string
}

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

variable "region_2" {
  type = string
}

variable "ami_ubuntu_2" {
  type = string
}

variable "instance_type_t2_mi_2ro_2" {
  type = string
}

variable "zone_a" {
  type = string
}

variable "zone_b" {
  type = string
}


variable "module" {
  type = string
}

variable "module_2" {
  type = string
}

