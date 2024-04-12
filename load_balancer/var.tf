variable "security_group_id" {
  type = string
}

variable "lb_public_subnet_ids" {
  type=list(string)
}

variable "vpc_id" {
  type = string
}

variable "instanece_ids" {
  type = map(object({
    instanece_id = string
    port = number
  }))
}