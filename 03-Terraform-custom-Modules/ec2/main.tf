resource "aws_instance" "ec2" {
  ami                    = var.ec2-ami
  instance_type          = var.ec2-instance_type
  key_name               = var.ec2-key_name
  subnet_id              = var.ec2-subnet_id
  vpc_security_group_ids = var.ec2-sg
  tags = {
    Name    = var.ec2-name-tag
    Creator = "Terraform"
  }
}

