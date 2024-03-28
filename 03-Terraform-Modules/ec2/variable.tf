variable "ec2-ami" {
  type = string
}

variable "ec2-instance_type" {
  type = string
}

variable "ec2-key_name" {
  type = string
}

variable "ec2-subnet_id" {
  type = string
}

variable "ec2-sg" {
  type = list(string)
}

variable "ec2-name-tag" {
  type = string
}