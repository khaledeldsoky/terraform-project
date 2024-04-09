variable "iti_vpc_cidr_block_var" {
  type = string
}





variable "subnets" {
  type = map(object({
    cidr_block = string
    AZ = string
  }))
}


variable "region_var" {
  type = string
}

variable "zone" {
  type = string
}

variable "module" {
  type = string
}