resource "aws_instance" "webserver" {
  # ami           = "ami-026255a2746f88074" # Provide the AMI ID
  ami = var.ec2_ami_id
  instance_type = var.ec2_instsnce_type
  key_name = aws_key_pair.ecom-key-pair.key_name
  tags = {
    Name    = "LWP-Webserver"
    Creator = "Terraform"
  }
}


# resource "aws_instance" "appserver" {
#   # ami           = "ami-026255a2746f88074" # Provide the AMI ID
#   ami = var.ec2_ami_id
#   instance_type = var.ec2_instsnce_type
#   tags = {
#     Name    = "LWP-appserver"
#     Creator = "Terraform"
#   }
# }