resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = merge(
    { "Name" = var.vpc_name },
    var.tags,
    var.vpc_tags,
    { "EnvironmentName" = local.environment_name }
  )
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { "Name" = var.igw },
    var.tags,
    var.vpc_tags,
    { "EnvironmentName" = local.environment_name }
  )
}

# Use data source to get all availability zones in the region
data "aws_availability_zones" "available_zones" {}

# Create public subnets dynamically based on variable
resource "aws_subnet" "public_subnets" {
  count                   = var.enable_public_subnets ? length(var.public_subnet_cidr) : 0
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = try(var.public_subnet_cidr[count.index], null)
  availability_zone       = try(data.aws_availability_zones.available_zones.names[count.index], null)
  map_public_ip_on_launch = true

  tags = merge(
    { "Name" = "public-subnet-az${count.index + 1}" },
    var.tags,
    var.vpc_tags,
    { "EnvironmentName" = var.environment }
  )
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = merge(
    { "Name" = "public_route_table" },
    var.tags,
    var.vpc_tags,
    { "EnvironmentName" = local.environment_name }
  )
}

resource "aws_route_table_association" "public_subnet_route_table_associations" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "private_subnets" {
  count                   = var.enable_private_subnets ? length(var.private_subnet_cidr) : 0
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = try(var.private_subnet_cidr[count.index], null)
  availability_zone       = try(data.aws_availability_zones.available_zones.names[count.index], null)
  map_public_ip_on_launch = false

  tags = merge(
    { "Name" = "private-subnet-az${count.index + 1}" },
    var.tags,
    var.vpc_tags,
    { "EnvironmentName" = var.environment }
  )
}

resource "aws_subnet" "container_subnet" {
  count                   = var.enable_container_subnet ? 1 : 0
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.container_subnet_cidr
  availability_zone       = try(data.aws_availability_zones.available_zones.names[0], null)
  map_public_ip_on_launch = false

  tags = merge(
    { "Name" = "container-subnet" },
    var.tags,
    var.vpc_tags,
    { "EnvironmentName" = local.environment_name }
  )
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = var.enable_nat_gateway ? 1 : 0
  allocation_id = try(aws_eip.nat_eip[count.index].id, null)
  subnet_id     = try(aws_subnet.public_subnets[0].id, null)

  tags = merge(
    { "Name" = var.nat_gateway },
    var.tags,
    var.vpc_tags,
    { "EnvironmentName" = local.environment_name }
  )
}

resource "aws_eip" "nat_eip" {
  count  = var.enable_nat_gateway ? 1 : 0
  domain = "vpc"

  tags = merge(
    { "Name" = var.nat_eip },
    var.tags,
    var.vpc_tags,
    { "EnvironmentName" = local.environment_name }
  )
}

resource "aws_network_acl" "nacl" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { "Name" = var.nacl },
    var.tags,
    var.vpc_tags,
    { "EnvironmentName" = local.environment_name }
  )
}

resource "aws_network_acl_rule" "inbound_rules" {
  count          = 2
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = count.index + 100
  protocol       = "-1"
  rule_action    = "allow"
  egress         = false
  from_port      = 0
  to_port        = 0
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "outbound_rules" {
  count          = 2
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = count.index + 200
  protocol       = "-1"
  rule_action    = "allow"
  egress         = true
  from_port      = 0
  to_port        = 0
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_association" "public_subnet_nacl_association" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  network_acl_id = aws_network_acl.nacl.id
}

####################################
#     Security group with vpc      #
####################################
resource "aws_security_group" "my_security_group" {
  name        = var.security_group
  description = "My Security Group"
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.enable_ingress ? [
      {
        from_port  = 22,
        to_port    = 22,
        protocol   = "tcp",
        cidr_block = "0.0.0.0/0"
      },
      {
        from_port  = 80,
        to_port    = 80,
        protocol   = "tcp",
        cidr_block = "0.0.0.0/0"
      }
    ] : []

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.cidr_block]
    }
  }

  dynamic "egress" {
    for_each = var.enable_egress ? [
      {
        from_port  = 0,
        to_port    = 0,
        protocol   = "-1",
        cidr_block = "0.0.0.0/0"
      }
    ] : []

    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = [egress.value.cidr_block]
    }
  }

  tags = merge(
    { "Name" = var.security_group },
    var.tags,
    var.vpc_tags,
    { "EnvironmentName" = local.environment_name }
  )
}
