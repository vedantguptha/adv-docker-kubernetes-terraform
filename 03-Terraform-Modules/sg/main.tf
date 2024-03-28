resource "aws_security_group" "sg" {
  vpc_id = var.sg-vpc_id
  name   = var.sg-name

  dynamic "ingress" {
    for_each = var.sg-inbound-port-numbers
    content {
      protocol    = var.sg-protocol
      from_port   = ingress.value
      to_port     = ingress.value
      cidr_blocks = [var.sg-internet-cidr]
    }
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.sg-internet-cidr]
  }
  tags = {
    Name    = var.sg-tag-name
    Creator = "Terraform"
  }
}