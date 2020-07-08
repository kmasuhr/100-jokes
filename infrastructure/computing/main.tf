data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"
    ]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"
    ]
  }

  owners = [
    "099720109477"
  ]
}

resource "aws_key_pair" "main" {
  key_name = "publicKey"
  public_key = file(var.public_key_path)
}


resource "aws_instance" "testInstance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = var.subnet_id

  vpc_security_group_ids = []

  key_name = aws_key_pair.main.key_name
}
