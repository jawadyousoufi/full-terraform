resource "random_password" "password" {
  length           = 30
  special          = false
  override_special = "_%@"
}


resource "aws_ssm_parameter" "foo" {
  name  = "foo"
  type  = "SecureString"
  value = random_password.password.result
}



resource "aws_db_instance" "default" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.16"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  password             = random_password.password.result
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
