

resource "aws_security_group" "ctops-allow-ssh-connection" {
  vpc_id = aws_vpc.ctops-vpc.id
  name   = title("allow-ssh-connection")
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [var.internet-cidr]
    description = "SSH"
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.internet-cidr]
  }
  tags = {
    Name    = title("${var.project-name}-allow-ssh-connection")
    Creator = var.resource_creator
  }
}


resource "aws_security_group" "ctops-web-security-group" {
  vpc_id = aws_vpc.ctops-vpc.id
  name   = title("webserver security group")

  dynamic "ingress" {
    for_each = var.inbound-port-numbers
    content {
      protocol    = "tcp"
      from_port   = ingress.value
      to_port     = ingress.value
      cidr_blocks = [var.internet-cidr]
    }
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.internet-cidr]
  }
  tags = {
    Name    = title("${var.project-name}-web-security-group")
    Creator = var.resource_creator
  }
}