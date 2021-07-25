#Rede aline-vpc
resource "aws_vpc" "aline_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "aline-vpc"
  }
}

#Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.aline_vpc.id
  tags = {
    Name = "aline_vpc_gw"
  }
}

#Sub-rede vms
resource "aws_subnet" "vms" {
  vpc_id                  = aws_vpc.aline_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "vms"
  }
}

#Sub-rede databases
resource "aws_subnet" "databases" {
  vpc_id            = aws_vpc.aline_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "databases"
  }
}

#Route table
resource "aws_route_table" "aline_vpc_route_table" {
  vpc_id = aws_vpc.aline_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id    
  }

  tags = {
    Name = "aline-vpc-route-table"
  }
}

resource "aws_route_table_association" "aline_vpc_route_table_vms" {
  subnet_id      = "${aws_subnet.vms.id}"
  route_table_id = "${aws_route_table.aline_vpc_route_table.id}"
}
