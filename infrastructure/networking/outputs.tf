output "subnet_id" {
  value = aws_subnet.main.id
}

output "default_security_group_id" {
  value = aws_security_group.main.id
}
