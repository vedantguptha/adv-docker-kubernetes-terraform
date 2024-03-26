variable "ec2_ami_id" {
  type        = string
  description = "EC2 AMI ID"
  default     = "ami-026255a2746f88074"
}


variable "ec2_instsnce_type" {
  type        = string
  description = "Type Of instsnce"
  default     = "t2.micro"
}


variable "vpa_cidr_block" {
  type        = string
  default     = "10.17.0.0/24"
  description = "CIDIR BLOCK"
}


variable "pub-subnets" {
  type = list(string)
  default = [ "10.0.0.0/26", "10.0.0.64/26" ]
}