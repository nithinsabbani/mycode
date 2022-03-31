//creating a vpc //
resource "aws_vpc" "infra"{
cidr_block = "10.0.0.0/16"
tags = {
"Name" = "myvpc1"
}
}
//creating internet and attaching gateway //
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.infra.id
    tags = {
    "Name" = "igw"
  }
}
//creating two subnets one public subnets //
resource "aws_subnet" "sn1" {
  vpc_id     = aws_vpc.infra.id
  cidr_block = "10.0.0.0/25"
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "public-1"
  }
}
resource "aws_subnet" "sn2" {
  vpc_id     = aws_vpc.infra.id
  cidr_block = "10.0.1.0/25"
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "public-2"
  }
}
resource "aws_subnet" "sn3" {
  vpc_id     = aws_vpc.infra.id
  cidr_block = "10.0.2.0/25"
  map_public_ip_on_launch = "false"
  tags = {
    "Name" = "private-1"
  }
}
resource "aws_subnet" "sn4" {
  vpc_id     = aws_vpc.infra.id
  cidr_block = "10.0.3.0/25"
  map_public_ip_on_launch = "false"
  tags = {
    "Name" = "private-2"
  }
}
//creating public route //
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.infra.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  }
//rt association to public sn1 //
resource "aws_route_table_association" "art" {
  subnet_id      = aws_subnet.sn1.id
  route_table_id = aws_route_table.rt.id
}
//rt association to public sn2 //
resource "aws_route_table_association" "art" {
  subnet_id      = aws_subnet.sn2.id
  route_table_id = aws_route_table.rt.id
}
resource "aws_nat_gateway" "gw" {
  subnet_id     = aws_subnet.sn3.id
  connectivity_type = "private"
   tags = {
    "Name" = "gw NAT"
  }
  }
 resource "aws_nat_gateway" "pgw1" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.sn3.id
}
