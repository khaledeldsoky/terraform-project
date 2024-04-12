resource "aws_instance" "ec2" {
  for_each                    = var.ec2
  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  associate_public_ip_address = each.value.associate_public_ip
  vpc_security_group_ids      = [each.value.secuirty_group]
  key_name                    = each.value.aws_key_pair_deployer_key_name_var
  subnet_id                   = each.value.subnet_id
user_data = <<EOF
#! /bin/bash
sudo apt-get update -y
sudo apt-get install -y openssh-server
sudo systemctl start ssh
sudo systemctl enable ssh
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Hello World from khaled</h1>" > /var/www/html/index.html
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

