resource "aws_vpc" "terraform_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "terraform_vpc"
  }
}

resource "aws_subnet" "terraform_subnet-public" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = var.public_subnet_az


  tags = {
    Name = "terraform_subnet-public"
  }
}
resource "aws_subnet" "terraform_subnet-private" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = var.private_subnet_cidr_block
  availability_zone = var.private_subnet_az


  tags = {
    Name = "terraform_subnet-private"
  }
}
resource "aws_internet_gateway" "terraform_gw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "terraform_gw"
  }
}

resource "aws_route_table" "terraform_public_RT" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_gw.id
  }

  

  tags = {
    Name = "terraform_public_RT"
  }
}

resource "aws_route_table_association" "public_RT_SUBNET" {
  subnet_id      = aws_subnet.terraform_subnet-public.id
  route_table_id = aws_route_table.terraform_public_RT.id
}
