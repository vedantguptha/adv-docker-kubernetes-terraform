resource "aws_instance" "jum-host" {
  ami                    = var.AMIS
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ctops-key-pair.key_name
  subnet_id              = aws_subnet.ctops-public-subnet[0].id
  vpc_security_group_ids = [aws_security_group.ctops-allow-ssh-connection.id, aws_security_group.ctops-web-security-group.id]
  tags = {
    Name    = title("${var.project-name}-jumphost")
    Creator = var.resource_creator
  }
}

