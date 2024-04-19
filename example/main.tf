module "vpc" {
  source                       = "../modules/vpc"
  environment                  = var.environment
  environment_type             = var.environment_type
  region                       = var.region
  vpc_cidr                     = var.vpc_cidr
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
  container_subnet_cidr        = var.container_subnet_cidr
}

module "security_groups" {
  source = "../modules/security_group
  environment      = var.environment
  environment_type = var.environment_type
  region           = var.region
  vpc_id           = module.vpc.vpc_id
}

