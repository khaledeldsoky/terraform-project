resource "aws_key_pair" "deployer" {
  key_name   = "khaled-key"
  public_key = tls_private_key.rsa-4096.public_key_openssh

  tags = {
    key_name = "key_pair_public"
  }
  
}

resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


