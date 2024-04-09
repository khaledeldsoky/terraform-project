resource "aws_instance" "ec2" {
  for_each                    = var.ec2
  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  associate_public_ip_address = each.value.associate_public_ip
  vpc_security_group_ids      = [each.value.secuirty_group]
  key_name                    = each.value.aws_key_pair_deployer_key_name_var
  subnet_id                   = each.value.subnet_id
  user_data                   = <<EOF
                                    apt update
                                    apt install -y openssh-server
                                    systemctl start ssh
                                    systemctl enable ssh
                                    apt install apache2
                                    systemctl start apache2
                                    systemctl enable apache2
                                  EOF
  provisioner "local-exec" {
    command = <<-OEF
      echo '${var.tls_private_key_var}' > ./khaled-key${each.key}.pem
      chmod 600 ./khaled-key${each.key}.pem 
  OEF
  }

  provisioner "local-exec" {
    command = <<-EOF
    echo "" >> /mnt/linux/data/project/final-project/ansible/hosts
    echo ${self.public_ip} >> /mnt/linux/data/project/final-project/ansible/hosts
    EOF
  }
  tags = {
    Name = each.key
  }
}

# resource "aws_instance" "ec2_public1" {
#   ami                         = data.aws_ami.ubuntu22.id
#   instance_type               = var.instance_type_t2_micro
#   subnet_id                   = var.subnet_id_public_var
#   vpc_security_group_ids      = [var.secuirty_group_id_public_var]
#   associate_public_ip_address = true
#   key_name                    = var.aws_key_pair_deployer_key_name_var #aws_key_pair.deployer.key_name
#   availability_zone = "${var.region_var}${var.zone_public}"

#   connection {
#     type        = "ssh"
#     user        = "ubuntu"
#     private_key = var.tls_private_key_var #file("./khaled-key.pem")
#     host        = self.public_ip
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt update",
#       "sudo apt install -y openssh-server",
#       "sudo systemctl start ssh",
#       "sudo systemctl enable ssh",
#   #     # "sudo mkdir -p /home/ec2-user/.ssh/",
#   #     # "sudo chmod 740 /home/ec2-user/.ssh/",
#   #     # "sudo touch /home/ec2-user/.ssh/id_rsa"
#     ]
#   }
#   provisioner "local-exec" {
#     command = <<-OEF
#       echo '${var.tls_private_key_var}' > ./khaled-key${var.module}.pem
#       chmod 600 ./khaled-key${var.module}.pem 
#   OEF
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt update",
#       "sudo apt install -y openssh-server",
#       "sudo systemctl start ssh",
#       "sudo systemctl enable ssh",
#   #     # "sudo mkdir -p /home/ec2-user/.ssh/",
#   #     # "sudo chmod 740 /home/ec2-user/.ssh/",
#   #     # "sudo touch /home/ec2-user/.ssh/id_rsa"
#     ]
#   }

#   provisioner "local-exec" {
#     command = <<-EOF
#     echo " " >> /mnt/linux/data/project/final-project/ansible/hosts
#     echo ${self.public_ip} >> /mnt/linux/data/project/final-project/ansible/hosts
#     EOF
#   }
#   # provisioner "file" {
#   #   source      = "./khaled-key.pem"
#   #   destination = "/home/ubuntu/.ssh/id_rsa"
#   #   # connection {
#   #   #   type        = "ssh"
#   #   #   user        = "ubuntu"
#   #   #   private_key = var.tls_private_key_var #tls_private_key.rsa-4096.private_key_pem
#   #   #   host        = self.public_ip
#   #   # }
#   # }
#   tags = {
#     "Name" : "ec2_public ${var.module}"
#   }

# }

# ################# private #################

# resource "aws_instance" "ec2_private1" {
#   ami                    = data.aws_ami.ubuntu22.id
#   instance_type          = var.instance_type_t2_micro
#   subnet_id              = var.subnet_id_private_var
#   vpc_security_group_ids = [var.secourty_group_id_private_var]
#   key_name               = var.aws_key_pair_deployer_key_name_var #aws_key_pair.deployer.key_name

# availability_zone = "${var.region_var}${var.zone_private}"
#   tags = {
#     "Name" : "ec2_private ${var.module}"
#   }

# }
# #------------------------------ هااااااااااااااااااااااااااااام جدا
#  #terraform taint module.ec2.null_resource.ansible_provisioner 
# # عشان تخلي كل مره يتعمله رن حتي لو محصلش تغير
# # resource "null_resource" "ansible_provisioner" {
# #   depends_on = [aws_instance.ec2_public1]
# #   provisioner "local-exec" {
# #     command     = "ansible-playbook -i hosts playbook.yaml --key-file /mnt/linux/data/project/final-project/terraform/khaled-key${var.module}.pem "
# #     working_dir = "/mnt/linux/data/project/final-project/ansible"
# #   }
# # }

