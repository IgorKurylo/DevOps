# aws vpc 
resource "aws_vpc" "app_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name        = "${var.project}-vpc"
    Environment = var.environment
  }
}
# aws private subnet
resource "aws_subnet" "private_subnet" {
  count             = var.az_count
  cidr_block        = cidrsubnet(aws_vpc.app_vpc.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.app_vpc.id
  tags = {
    Name        = "${var.project}-private-subnet-${count.index}"
    Environment = var.environment

  }
}
# aws public subnet
resource "aws_subnet" "public_subnet" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.app_vpc.cidr_block, 8, var.az_count + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.app_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.project}-public-subnet-${count.index}"
    Environment = var.environment

  }
}

# aws internet gateway
resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name        = "${var.project}-igw"
    Environment = var.environment
  }
}
# aws nat gateway
resource "aws_nat_gateway" "app_nat_gw" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.public_subnet.*.id, count.index)
  allocation_id = element(aws_eip.app_eip.*.id, count.index)
  tags = {
    Name        = "${var.project}-nat-gw-${count.index}"
    Environment = var.environment
  }
}
# aws elastic ip 
resource "aws_eip" "app_eip" {
  count      = var.az_count
  vpc        = true
  depends_on = [aws_internet_gateway.app_igw]
}
# route the public subnet traffic via the IGW
resource "aws_route" "internet_route_access" {
  route_table_id         = aws_vpc.app_vpc.main_route_table_id
  gateway_id             = aws_internet_gateway.app_igw.id
  destination_cidr_block = "0.0.0.0/0"
}
# private route table via nat gateway
resource "aws_route_table" "private" {
  count  = var.az_count
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.app_nat_gw.*.id, count.index)
  }
  tags = {
    Name        = "${var.project}-private-rt"
    Environment = var.environment
  }
}

# route table association between subnets id and route tables
resource "aws_route_table_association" "private" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

# aws availability zones
data "aws_availability_zones" "available" {
  state = "available"
}
