data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"
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

resource "aws_instance" "main" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.default_security_group_id
  ]

  key_name = aws_key_pair.main.key_name
}

output "main_public_ip" {
  value = aws_instance.main.public_ip
}
