variable "sg-vpc_id" {
  type = string
}

variable "sg-inbound-port-numbers" {
  type = list(number)
}
variable "sg-internet-cidr" {
  type = string
}
variable "sg-protocol" {
  type = string
}
variable "sg-tag-name" {
  type = string
}

variable "sg-name" {
  type = string
}