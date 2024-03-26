##################################################################
##                       VPC Creation                           ##
##################################################################
resource "aws_vpc" "ctops-vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name    = title("${var.project-name}-${terraform.workspace}")
    Creator = var.resource_creator
  }
}
##################################################################
##                 Public Subnets Creation                      ##
##################################################################
resource "aws_subnet" "ctops-public-subnet" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.ctops-vpc.id
  cidr_block              = var.public-subnet-cidr[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name    = title("${var.project-name}-Public-Subnet-${count.index + 1}")
    Creator = var.resource_creator
  }
  depends_on = [ aws_vpc.ctops-vpc ]
}
#################################################################
#                       IGW Creation                           ##
#################################################################
resource "aws_internet_gateway" "ctops-igw" {
  vpc_id = aws_vpc.ctops-vpc.id
  tags = {
    Name    = title("${var.project-name}-IGW")
    Creator = var.resource_creator
  }
  depends_on = [ aws_vpc.ctops-vpc ]
}
##################################################################
##                 Public Route Table                           ##
##################################################################
resource "aws_route_table" "ctops-public-route-table" {
  vpc_id = aws_vpc.ctops-vpc.id
  route {
    cidr_block = var.internet-cidr
    gateway_id = aws_internet_gateway.ctops-igw.id
  }
  tags = {
    Name    = title("${var.project-name}-Public Routes")
    Creator = var.resource_creator
  }
  depends_on = [ aws_vpc.ctops-vpc, aws_subnet.ctops-public-subnet ]
}

##################################################################
##    Public Route Table Asscioation with Public Subnets        ##
##################################################################
resource "aws_route_table_association" "ctops-public-subnet-asscioations" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.ctops-public-subnet[*].id, count.index)
  route_table_id = aws_route_table.ctops-public-route-table.id
}