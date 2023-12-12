//vpc
resource "aws_vpc" "my_vpc" {
  cidr_block       = var.cidr_block[0]
  instance_tenancy = var.instance_tenancy

  tags = {
    Name = var.tags[0]
  }
}

//Subnet for vpc
resource "aws_subnet" "public-sub-01" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.cidr_block[1]
  availability_zone = var.availability_zone[0]
  tags = {
    Name = var.tags[1]
  }
}
resource "aws_subnet" "public-sub-02" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.cidr_block[2]
  availability_zone = var.availability_zone[1]

  tags = {
    Name = var.tags[2]
  }
}
resource "aws_subnet" "private-sub-01" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.cidr_block[3]
  availability_zone = var.availability_zone[1]


  tags = {
    Name = var.tags[3]
  }
}
resource "aws_subnet" "private-sub-02" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.cidr_block[4]
  availability_zone = var.availability_zone[0]

  tags = {
    Name = var.tags[4]
  }
}
#Internet_internet_geteway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = var.tags[5]
  }
}
#EIP
resource "aws_eip" "eip" {
  #instance = aws_instance.web.id
  domain = var.domain
}
#NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-sub-01.id

  tags = {
    Name = var.tags[6]
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}
#Public rout-table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = var.cidr_block[5]
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.tags[7]
  }
}
#public subnet-assosiation
resource "aws_route_table_association" "pub_subnet_01" {
  subnet_id      = aws_subnet.public-sub-01.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "pub_subnet_02" {
  subnet_id      = aws_subnet.public-sub-02.id
  route_table_id = aws_route_table.public.id
}
#private route-table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = var.cidr_block[5]
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = var.tags[8]
  }
}
#private subnet-assosiation
resource "aws_route_table_association" "pri_subnet_01" {
  subnet_id      = aws_subnet.private-sub-01.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "pri_subnet_02" {
  subnet_id      = aws_subnet.private-sub-02.id
  route_table_id = aws_route_table.private.id
}