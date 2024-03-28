
data "aws_vpc" "default-vpc" {}


module "allow-ssh" {
  source                  = "./sg"
  sg-name                 = title("SSH security group")
  sg-vpc_id               = data.aws_vpc.default-vpc.id
  sg-inbound-port-numbers = [22]
  sg-internet-cidr        = "0.0.0.0/0"
  sg-protocol             = "tcp"
  sg-tag-name             = "Test SG"
}


module "allow-web-server" {
  source                  = "./sg"
  sg-name                 = title("webserver security group")
  sg-vpc_id               = data.aws_vpc.default-vpc.id
  sg-inbound-port-numbers = [80, 8080, 443]
  sg-internet-cidr        = "0.0.0.0/0"
  sg-protocol             = "tcp"
  sg-tag-name             = "Webserver SG"
}