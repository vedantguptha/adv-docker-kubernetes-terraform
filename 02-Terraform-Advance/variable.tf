variable "project-name" {
  description = "ProjectName"
  type        = string
  default     = "ctops"
}
variable "resource_creator" {
  type    = string
  default = "Terraform"
}

variable "vpc_cidr" {
  description = "CIDR Range"
  type        = string
  default     = "10.17.0.0/24"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}


variable "public-subnet-cidr" {

  type    = list(string)
  default = ["10.17.0.0/26", "10.17.0.128/26"]
}

variable "private-subnet-cidr" {

  type    = list(string)
  default = ["10.17.0.64/26", "10.17.0.192/26"]
}

variable "subnet_count" {
  type    = number
  default = 2
}


variable "test" {
  type = map(object({
    cidr = string
    az   = string
  }))

  default = {
    "subnet1" = {
      cidr = "10.17.0.0/26"
      az   = "ap-south-1a"
    },
    "subnet2" = {
      cidr = "10.17.0.64/26"
      az   = "ap-south-1b"
    }

  }

}

variable "internet-cidr" {
  type = string
  default = "0.0.0.0/0"
}