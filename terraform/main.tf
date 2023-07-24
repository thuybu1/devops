# CREATE VPC & SUBNETTING
module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  vpc_name        = "${var.project_prefix}-VPC"
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  common_tags     = var.common_tags
}

# GENERATE SECURITY GROUPS
module "security_groups" {
  source      = "./modules/sg"
  vpc_id      = module.vpc.vpc_id
  common_tags = var.common_tags
}

# GENERATE KEY FOR THE WEB SERVER
module "ws_key" {
  source         = "./modules/key"
  project_prefix = var.project_prefix
  common_tags    = var.common_tags
}

# MAIN WEB SERVER FOR DEPLOYING CODES
module "origin_ws_instance" {
  source             = "./modules/ec2"
  project_prefix     = var.project_prefix
  key_name           = module.ws_key.key_name
  instance_name      = var.origin_name
  security_group_ids = [module.security_groups.web_instance_sg_id]
  subnet_id          = module.vpc.public_subnet[0].id
  common_tags        = var.common_tags
  ami_type           = var.ami_type
  instance_type      = var.instance_type
  user_data          = var.user_data
}



