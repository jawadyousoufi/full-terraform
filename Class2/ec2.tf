#  Pulls AMI ID from AWS Region

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}




resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.large"
  vpc_security_group_ids      = [aws_security_group.ec2-class-sec-group.id]
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"
  key_name                    = aws_key_pair.deployer.key_name
  tags                        = local.common_tags



  provisioner "remote-exec" {
    connection {
      host        = aws_instance.web.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
    }
    inline = [
      "sudo apt-get install apache2 -y",
    ]
  }
}







resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 40
  tags              = local.common_tags
}
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.web.id

}