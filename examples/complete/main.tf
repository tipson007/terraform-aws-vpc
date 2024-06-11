module "custom_vpc" {
  source = "../../"

  vpc_cidr                = "10.0.0.0/16"
  region                  = "eu-west-1"
  vpc_name                = "my-vpc"
  igw                     = "my-igw"
  public_subnet_cidr      = ["10.0.1.0/24"]
  private_subnet_cidr     = ["10.0.2.0/24"]
  availability_zones      = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  container_subnet_cidr   = "10.0.7.0/24"
  nat_gateway             = "my-nat-gateway"
  nat_eip                 = "my-nat-eip"
  nacl                    = "my-nacl"
  security_group          = "my-security-group"
  environment             = "dev"
  environment_type        = "test"
  enable_public_subnets   = true
  enable_private_subnets  = true
  enable_container_subnet = true
  enable_nat_gateway      = true
  enable_ingress          = true
  enable_egress           = true

  vpc_tags = {
    "Department" = "Engineering"
    "Owner"      = "xx"
  }

  tags = {
    "Project" = "xx"
    "Team"    = "xx"
  }
}