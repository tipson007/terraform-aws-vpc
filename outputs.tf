output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  description = "The IDs of the private app subnets"
  value       = aws_subnet.private_subnets[*].id
}

output "container_subnet_id" {
  description = "The ID of the container subnet"
  value       = aws_subnet.container_subnet[*].id
}

output "availability_zones" {
  description = "The availability zones."
  value       = data.aws_availability_zones.available_zones.names
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat_gateway[*].id
}

output "nat_eip_id" {
  description = "The ID of the NAT Elastic IP"
  value       = aws_eip.nat_eip[*].id
}

output "nacl_id" {
  description = "The ID of the Network ACL"
  value       = aws_network_acl.nacl[*].id
}

output "security_group_id" {
  description = "The ID of the Security Group"
  value       = aws_security_group.my_security_group[*].id
}
