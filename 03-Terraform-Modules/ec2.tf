
module "jump-host" {
  source = "./ec2"
  ec2-ami = var.AMIS
  ec2-instance_type = var.ec2-type
  ec2-key_name = aws_key_pair.ctops-key-pair.key_name
  ec2-sg = [module.allow-ssh.sg-id, module.allow-web-server.sg-id]
  ec2-subnet_id = "subnet-0b21011c48cd7e6fc"
  ec2-name-tag = "Test-webserver"
}