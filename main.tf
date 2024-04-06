module "network" {
  source                        = "./network"
  iti_vpc_cidr_block_var        = var.vpc_cidr_block
  subnet_public_cidr_block_var  = var.subnet_public_cidr_block
  subnet_private_cidr_block_var = var.subnet_private_cidr_block
  region_var                    = var.region
}

module "secuirty" {
  source              = "./secrets"
  vpc_id_var          = module.network.vpc_id
  vpc_cidr_blocks_var = var.vpc_cidr_block
  region_var          = var.region
}

module "ec2" {
  source                             = "./ec2"
  subnet_id_public_var               = module.network.subnet_public_id
  subnet_id_private_var              = module.network.subnet_private_id
  secourty_group_id_private_var      = module.secuirty.secuirty_group_id_private
  secuirty_group_id_public_var       = module.secuirty.secuirty_group_id_public
  tls_private_key_var                = module.secuirty.private_key
  aws_key_pair_deployer_key_name_var = module.secuirty.aws_key_pair_deployer_key_name
  region_var                         = var.region
  ami_ubuntu                         = var.ami_ubuntu
  instance_type_t2_micro             = var.instance_type_t2_micro
}
