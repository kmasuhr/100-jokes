resource "aws_vpc" "main" {
  cidr_block = var.cidr_vpc
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.cidr_subnet
  map_public_ip_on_launch = true
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "main" {
  subnet_id = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}


resource "aws_security_group" "main" {
  name = "sg_default"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "egress_all" {
  security_group_id = aws_security_group.main.id
  type = "egress"

  from_port = 0
  to_port = 0
  protocol = "-1"

  cidr_blocks = [
    "0.0.0.0/0"
  ]
}

resource "aws_security_group_rule" "ingress_ssh" {
  security_group_id = aws_security_group.main.id
  type = "ingress"

  from_port = 22
  to_port = 22
  protocol = "tcp"

  cidr_blocks = [
    "0.0.0.0/0"
  ]
}

resource "aws_security_group_rule" "ingress_app" {
  security_group_id = aws_security_group.main.id
  type = "ingress"

  from_port = 0
  to_port = 3000
  protocol = "tcp"

  cidr_blocks = [
    "0.0.0.0/0"
  ]
}
