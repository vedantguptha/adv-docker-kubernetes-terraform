##################################################################
##                   SSH Key Generation                         ##
##################################################################
resource "tls_private_key" "ctops-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

##################################################################
##                  AWS Key Pair Creation                       ##
##################################################################
resource "aws_key_pair" "ctops-key-pair" {
  key_name   = "ctops"
  public_key = tls_private_key.ctops-key.public_key_openssh
}

##################################################################
##                   .Pem file Creation                         ##
##################################################################
resource "local_file" "key_file" {
  filename = "${aws_key_pair.ctops-key-pair.key_name}.pem"
  content  = tls_private_key.ctops-key.private_key_openssh
}