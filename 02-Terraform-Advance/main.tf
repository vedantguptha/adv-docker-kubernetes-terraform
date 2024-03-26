terraform {
  backend "s3" {
    bucket = "b84-adv-docker-k8-terraform-projects"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.41.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}