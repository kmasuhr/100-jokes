provider "aws" {
  region = "eu-west-1"
}

module "networking" {
  source = "./networking"
  cidr_subnet = var.cidr_subnet
  cidr_vpc = var.cidr_vpc
}

module "computing" {
  source = "./computing"

  default_security_group_id = module.networking.default_security_group_id
  public_key_path = var.public_key_path
  subnet_id = module.networking.subnet_id
}
