data "aws_ami" "ubuntu22" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

variable "ec2" {
type = map(object({
  ami = string
  instance_type = string
  associate_public_ip = bool
  subnet_id = string
  secuirty_group = string
  aws_key_pair_deployer_key_name_var  = string
}))
}

variable "tls_private_key_var" {
  type = string
}

# variable "associate_public_ip" {
#   type = bool
# }



# variable "subnet_id_public_var" {
#   type = string
# }

# variable "ami_ubuntu" {
#   type = string
# }

# variable "instance_type_t2_micro" {
#   type = string
# }

# variable "secuirty_group_id_public_var" {
#   type = string
# }

# variable "aws_key_pair_deployer_key_name_var" {
#   type = string
# }



# variable "subnet_id_private_var" {
#   type = string
# }

# variable "secourty_group_id_private_var" {
#   type = string
# }

# variable "region_var" {
#   type = string
# }

# variable "zone_public" {
#   type = string
# }

# variable "zone_private" {
#   type = string
# }

# variable "module" {
#   type = string
# }