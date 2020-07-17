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
  public_key_path = "${var.public_key_path}.pub"
  subnet_id = module.networking.subnet_id
}

output "main_vm_ssh_config" {
  value = <<CONFIG

Host scalac
    HostName ${module.computing.main_public_ip}
    User ubuntu
    IdentityFile ${var.public_key_path}
    LocalForward 8080 localhost:8080
CONFIG
}
