resource "aws_instance" "ec2_public" {
  ami                         = data.aws_ami.ubuntu22.id
  instance_type               = var.instance_type_t2_micro
  subnet_id                   = var.subnet_id_public_var
  vpc_security_group_ids      = [var.secuirty_group_id_public_var]
  associate_public_ip_address = true
  key_name                    = var.aws_key_pair_deployer_key_name_var #aws_key_pair.deployer.key_name
  availability_zone           = "us-east-1a"

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./khaled-key.pem")
    host        = self.public_ip
  }

  provisioner "local-exec" {
    command = "echo '${var.tls_private_key_var}' > ./khaled-key.pem "
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y openssh-server",
      "sudo systemctl start ssh",
      "sudo systemctl enable ssh",
      "sudo mkdir -p /home/ec2-user/.ssh/",
      "sudo chmod 740 /home/ec2-user/.ssh/",
      "sudo touch /home/ec2-user/.ssh/id_rsa"

    ]
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ip.txt"
  }

  provisioner "file" {
    source      = "./khaled-key.pem"
    destination = "/home/ubuntu/.ssh/id_rsa"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.tls_private_key_var #tls_private_key.rsa-4096.private_key_pem
      host        = self.public_ip
    }
  }

  tags = {
    "Name" : "ec2_public"
  }

}
################# private #################

resource "aws_instance" "ec2_private" {
  ami                    = data.aws_ami.ubuntu22.id
  instance_type          = var.instance_type_t2_micro
  subnet_id              = var.subnet_id_private_var
  vpc_security_group_ids = [var.secourty_group_id_private_var]
  key_name               = var.aws_key_pair_deployer_key_name_var #aws_key_pair.deployer.key_name

  availability_zone = "${var.region_var}a"
  tags = {
    "Name" : "ec2_private"
  }
  
}

