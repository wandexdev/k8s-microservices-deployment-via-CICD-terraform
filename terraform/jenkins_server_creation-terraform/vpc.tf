#--------------------------------------VPC--------------------#

resource "aws_vpc" "wandek8s-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.environment_prefix}-vpc"
  }
}

#--------------------------------SUBNET-------------------------#

resource "aws_subnet" "wandek8s-subnet" {
  vpc_id            = aws_vpc.wandek8s-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = "${var.environment_prefix}-subnet"
  }
}

#--------------------------------IGW------------------------------------#

resource "aws_internet_gateway" "wandek8s-igw" {
  vpc_id = aws_vpc.wandek8s-vpc.id
  tags = {
    Name = "${var.environment_prefix}-igw"
  }
}

#--------------------------------SG------------------#

resource "aws_default_security_group" "default-sg" {
  vpc_id = aws_vpc.wandek8s-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.environment_prefix}-default-sg"
  }
}

#---------------------------------RT-------------------#

resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.wandek8s-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wandek8s-igw.id
  }
  tags = {
    Name = "${var.environment_prefix}-main-rtb"
  }
}
