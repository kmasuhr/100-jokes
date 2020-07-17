variable "cidr_vpc" {
  type = string
  default = "10.0.0.0/16"
}

variable "cidr_subnet" {
  type = string
  default = "10.0.0.0/24"
}

variable "public_key_path" {
  type = string
  default = "~/.ssh/scalac/id_rsa"
}
