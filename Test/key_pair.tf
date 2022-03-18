resource "aws_key_pair" "deployer" {
  key_name_prefix   = var.name
  public_key =  var.public_key
}