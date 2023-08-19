# create vpc
resource "aws_vpc" "vpc_cidr" {
  cidr_block              = var.vpc_cidrblock
  instance_tenancy        = default
  enable_dns_hostnames    = true

  tags      = {
    Name    = "${var.production}-${var.testing}-${var.developing}-vpc"
  }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "web_igw" {
  vpc_id    = aws_vpc.vpc_cidr.id

  tags      = {
    Name    = "${var.production}-${var.testing}-${var.developing}-igw"
  }
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}

# create public subnet 1
resource "aws_subnet" "web_public_subnet1" {
  vpc_id                  = aws_vpc.vpc_cidr.id
  cidr_block              = var.web_public_subnet1_cider
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "${var.production}-${var.testing}-${var.developing}-pubsubnet1"
  }
}

# create public subnet 2
resource "aws_subnet" "web_public_subnet2" {
  cidr_block              = var.web_public_subnet2_cider
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "${var.production}-${var.testing}-${var.developing}-pubsubnet2"
  }
}

# create route table and add public route
resource "aws_route_table" "web_public_route_table" {
  vpc_id       = aws_vpc.vpc_cidr.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internate_gatway.web_igw.id
  }

  tags       = {
    Name     = "${var.production}-${var.testing}-${var.developing}-routetable"
  }
}

# associate public subnet 1 to "public route table"
resource "aws_route_table_association" "web_public_subnet1_web_public_route_table_association" {
  subnet_id           = aws_subnet.web_public_subnet1.id
  route_table_id      = aws_route_table.web_public_route_table.id
}

# associate public subnet 2 to "public route table"
resource "aws_route_table_association" "public_subnet_2_route_table_association" {
  subnet_id           = aws_subnet.web_public_subnet2.id
  route_table_id      = aws_route_table.web_public_route_table.id
}

# create private web subnet 1
resource "aws_subnet" "web_private_subnet1" {
  vpc_id                   = aws_vpc.vpc_cidr.id
  cidr_block               = var.web_private_subnet1_cider
  availability_zone        = data.aws_availability_zones.available_zones.names[2]
  map_public_ip_on_launch  = true

  tags      = {
    Name    = "${var.production}-${var.testing}-${var.developing}-privatesub1"
  }
}

# create private web subnet 2
resource "aws_subnet" "web_private_subnet2" {
  vpc_id                   = aws_vpc.vpc_cidr.id
  cidr_block               = web_private_subnet2_cider
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = true

  tags      = {
    Name    = "${var.production}-${var.testing}-${var.developing}-privatesub2"
  }
}
