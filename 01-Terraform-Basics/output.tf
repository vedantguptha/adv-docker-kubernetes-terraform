output "vpc_id" {
  value = aws_vpc.lwp-ecom-dev-vpc.id
}

output "vpc_arn" {
  value = aws_vpc.lwp-ecom-dev-vpc.arn
}


output "ecom-igw-id" {
  value = aws_internet_gateway.ecom-igw.id
}


output "ec2-pip" {
  value = aws_instance.webserver.public_ip
}

output "ec2-privateip" {
  value = aws_instance.webserver.private_ip
}