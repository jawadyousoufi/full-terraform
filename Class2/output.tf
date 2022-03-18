
output "all" {
  value = aws_instance.web.public_ip
}

output "ami" {
  value = aws_instance.web.ami
}

output "az" {
  value = aws_instance.web.availability_zone
}