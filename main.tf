module "network" {

  source = "./network"

  subnets = {

    "private_subnet_1" = {
      cidr_block = "10.0.1.0/24"
      AZ         = 0
      # map_ip = bool
      route_table = "private_route_table"
    }

    "private_subnet_2" = {
      cidr_block = "10.0.2.0/24"
      AZ         = 1
      # map_ip = bool
      route_table = "private_route_table"
    }

    "public_subnet_1" = {
      cidr_block = "10.0.3.0/24"
      AZ         = 0
      # map_ip = bool
      route_table = "public_route_table"
    }

    "public_subnet_2" = {
      cidr_block = "10.0.4.0/24"
      AZ         = 1
      # map_ip = bool
      route_table = "public_route_table"
    }

  }


  route_table = {

    "public_route_table" = {
      cidr_block = "0.0.0.0/0"
      gateway_id = module.network.gatway_id
    }

    "private_route_table" = {
      cidr_block = "0.0.0.0/0"
      gateway_id = module.network.nat_id
    }

  }
  vpc_cidr_block = "10.0.0.0/16"
}







module "ec2" {
  source = "./ec2"
  ec2 = {
    "private_ec2_1" = {
      ami                                = "ami-080e1f13689e07408"
      instance_type                      = "t2.micro"
      associate_public_ip                = false
      subnet_id                          = module.network.subnet_id["private_subnet_1"]
      secuirty_group                     = module.secert.secuirty_group_id_private
      aws_key_pair_deployer_key_name_var = module.secert.aws_key_pair_deployer_key_name
    }

    "private_ec2_2" = {
      ami                                = "ami-080e1f13689e07408"
      instance_type                      = "t2.micro"
      associate_public_ip                = false
      secuirty_group                     = module.secert.secuirty_group_id_private
      subnet_id                          = module.network.subnet_id["private_subnet_2"]
      aws_key_pair_deployer_key_name_var = module.secert.aws_key_pair_deployer_key_name
    }


    "public_ec2_1" = {
      ami                                = "ami-080e1f13689e07408"
      instance_type                      = "t2.micro"
      associate_public_ip                = true
      subnet_id                          = module.network.subnet_id["public_subnet_1"]
      secuirty_group                     = module.secert.secuirty_group_id_public
      aws_key_pair_deployer_key_name_var = module.secert.aws_key_pair_deployer_key_name
    }

    "public_ec2_2" = {
      ami                                = "ami-080e1f13689e07408"
      instance_type                      = "t2.micro"
      associate_public_ip                = true
      subnet_id                          = module.network.subnet_id["public_subnet_2"]
      secuirty_group                     = module.secert.secuirty_group_id_public
      aws_key_pair_deployer_key_name_var = module.secert.aws_key_pair_deployer_key_name
    }
  }
  tls_private_key_var = module.secert.private_key
}

module "secert" {
  source          = "./secret"
  vpc_id          = module.network.vpc_id
  vpc_cidr_blocks = module.network.vpc_cidr_block
}

module "lb" {
  source = "./load_balancer"
  security_group_id = module.secert.secuirty_group_id_public
  lb_public_subnet_ids = [
    module.network.subnet_id["public_subnet_2"], module.network.subnet_id["public_subnet_1"]
  ]
  vpc_id = module.network.vpc_id
  instanece_ids = {
   "publicEc21" ={  
    instanece_id = module.ec2.instance_ids["public_ec2_1"] 
    port = 80
    }
   "publicEc22" = {
    instanece_id = module.ec2.instance_ids["public_ec2_2"] 
    port = 80
    }
  } 
}