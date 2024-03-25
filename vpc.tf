##################################################################
##                       VPC Creation                           ##
##################################################################

resource "aws_vpc" "lwp-ecom-dev-vpc" {
  cidr_block           = var.vpa_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "Ecom-Dev-Vpc"
  }
}

##################################################################
##                 Webserver Subnet - 1                         ##
##################################################################

resource "aws_subnet" "ecom-web-sn-1" {
  vpc_id                  = aws_vpc.lwp-ecom-dev-vpc.id
  cidr_block              = "10.17.0.0/26"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Ecom-Public-subnet-1"
  }
depends_on = [ aws_vpc.lwp-ecom-dev-vpc ]
}

##################################################################
##                 Webserver Subnet - 2                         ##
##################################################################

resource "aws_subnet" "ecom-web-sn-2" {
  vpc_id                  = aws_vpc.lwp-ecom-dev-vpc.id
  cidr_block              = "10.17.0.128/26"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Ecom-Public-subnet-2"
  }

}


##################################################################
##                       IGW Creation                           ##
##################################################################

resource "aws_internet_gateway" "ecom-igw" {
  vpc_id = aws_vpc.lwp-ecom-dev-vpc.id
  tags = {
    Name = "ECOM-IGW"
  }
}

##################################################################
##                       PRT                                    ##
##################################################################

resource "aws_route_table" "ecom-prt" {
  vpc_id = aws_vpc.lwp-ecom-dev-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecom-igw.id
  }
  tags = {
    Name = "Ecom-Prt"
  }

}


resource "aws_route_table_association" "ecom-accoc-web-subnet-1" {
  subnet_id      = aws_subnet.ecom-web-sn-1.id
  route_table_id = aws_route_table.ecom-prt.id
}

resource "aws_route_table_association" "ecom-accoc-web-subnet-2" {
  subnet_id      = aws_subnet.ecom-web-sn-2.id
  route_table_id = aws_route_table.ecom-prt.id
}

##################################################################
##                 App Subnet - 1                           ##
##################################################################

resource "aws_subnet" "ecom-app-subnet" {
  vpc_id                  = aws_vpc.lwp-ecom-dev-vpc.id
  cidr_block              = "10.17.0.64/26"
  availability_zone       = "ap-south-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "Application-Private-Sub-Net"
  }

}

##################################################################
##                 DataBase Subnet                          ##
##################################################################

resource "aws_subnet" "ecom-db-subnet" {
  vpc_id                  = aws_vpc.lwp-ecom-dev-vpc.id
  cidr_block              = "10.17.0.192/26"
  availability_zone       = "ap-south-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "DB-Private-Sub-Net"
  }
}


##################################################################
##                         EIP Creation                         ##
##################################################################

resource "aws_eip" "ecom-eip" {
  domain = "vpc"
  tags = {
    Name = "ecom-VPC-Eip"
  }

}


##################################################################
##                    NAT Gateway Creation                      ##
##################################################################

resource "aws_nat_gateway" "ecom-nat" {
  allocation_id = aws_eip.ecom-eip.id
  subnet_id     = aws_subnet.ecom-web-sn-1.id
  tags = {
    Name = "Ecom-VPC-NG"
  }
}


##################################################################
##                 Private Route Table                           ##
##################################################################

resource "aws_route_table" "ecom-pvrt" {
  vpc_id = aws_vpc.lwp-ecom-dev-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ecom-nat.id
  }
  tags = {
    Name = "ecom-Private-rt"
  }
}


resource "aws_route_table_association" "ecom-app-subnet-accos-pivate-rt" {
  route_table_id = aws_route_table.ecom-pvrt.id
  subnet_id      = aws_subnet.ecom-app-subnet.id
}

resource "aws_route_table_association" "ecom-db-subnet-accos-pivate-rt" {
  route_table_id = aws_route_table.ecom-pvrt.id
  subnet_id      = aws_subnet.ecom-db-subnet.id
}

