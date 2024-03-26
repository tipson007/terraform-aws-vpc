# create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${local.environment_name}-vpc"
  }
}

# create internet gateway and attach it to the VPC
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.environment_name}-igw"
  }
}

# use data source to get all availability zones in the region
data "aws_availability_zones" "available_zones" {}

# create public subnets
resource "aws_subnet" "public_subnets" {
  count                   = length(local.public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.public_subnet_cidr_blocks[count.index]
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-az${count.index + 1}"
  }
}

# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# associate public subnets to the route table
resource "aws_route_table_association" "public_subnet_route_table_associations" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# create private app subnets
resource "aws_subnet" "private_app_subnets" {
  count                   = length(local.private_app_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.private_app_subnet_cidr_blocks[count.index]
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-app-subnet-az${count.index + 1}"
  }
}

# create private data subnets
resource "aws_subnet" "private_data_subnets" {
  count                   = length(local.private_data_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.private_data_subnet_cidr_blocks[count.index]
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-data-subnet-az${count.index + 1}"
  }
}

# create container subnet
resource "aws_subnet" "container_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.container_subnet_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "container-subnet"
  }
}

######

# Create NAT gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${local.environment_name}-nat-gateway"
  }
}

# Create Elastic IP for NAT gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${local.environment_name}-nat-eip"
  }
}

# Create Network Access Control List (NACL)
resource "aws_network_acl" "nacl" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.environment_name}-nacl"
  }
}

# Create inbound and outbound rules for NACL
resource "aws_network_acl_rule" "inbound_rules" {
  count              = 2
  network_acl_id     = aws_network_acl.nacl.id
  rule_number        = count.index + 100
  protocol           = "-1"
  rule_action        = "allow"
  egress             = false
  #rule_description   = "Allow inbound traffic"
  from_port          = 0
  to_port            = 0
  cidr_block         = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "outbound_rules" {
  count              = 2
  network_acl_id     = aws_network_acl.nacl.id
  rule_number        = count.index + 200
  protocol           = "-1"
  rule_action        = "allow"
  egress             = true
  #rule_description   = "Allow outbound traffic"
  from_port          = 0
  to_port            = 0
  cidr_block         = "0.0.0.0/0"
}

# Associate NACL with subnets
resource "aws_network_acl_association" "public_subnet_nacl_association" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  network_acl_id = aws_network_acl.nacl.id
}
