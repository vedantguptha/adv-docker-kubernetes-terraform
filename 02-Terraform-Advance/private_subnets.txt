
#################################################################
#                 Private Subnets Creation                      ##
#################################################################
resource "aws_subnet" "ctops-private-subnet" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.ctops-vpc.id
  cidr_block              = var.private-subnet-cidr[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name    = title("${var.project-name}-Private-Subnet-${count.index + 1}")
    Creator = var.resource_creator
  }
}
##################################################################
##                         EIP Creation                         ##
##################################################################
resource "aws_eip" "ctops-eip" {
  domain = "vpc"
  tags = {
    Name    = upper("${var.project-name}-EIP")
    Creator = var.resource_creator
  }
}
##################################################################
##                    NAT Gateway Creation                      ##
##################################################################
resource "aws_nat_gateway" "ctops-nat" {
  allocation_id = aws_eip.ctops-eip.id
  subnet_id     = aws_subnet.ctops-private-subnet[0].id
  tags = {
    Name    = upper("${var.project-name}-NAT")
    Creator = var.resource_creator
  }
  depends_on = [aws_internet_gateway.ctops-igw]
}
##################################################################
##                 Private Route Table                           ##
##################################################################
resource "aws_route_table" "ctops-private-route-table" {
  vpc_id = aws_vpc.ctops-vpc.id
  route {
    cidr_block = var.internet-cidr
    gateway_id = aws_nat_gateway.ctops-nat.id
  }
  tags = {
    Name    = upper("${var.project-name}-Private Routes")
    Creator = var.resource_creator
  }
}
##################################################################
##    Private Route Table Asscioation with Private Subnets      ##
##################################################################
resource "aws_route_table_association" "ctops-private-subnet-asscioations" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.ctops-private-subnet[*].id, count.index)
  route_table_id = aws_route_table.ctops-private-route-table.id
}