output "region" {
  description = "The region of the VPC"
  value       = var.region
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public_subnets[*].id
}

output "private_app_subnet_ids" {
  description = "The IDs of the private app subnets"
  value       = aws_subnet.private_app_subnets[*].id
}

output "private_data_subnet_ids" {
  description = "The IDs of the private data subnets"
  value       = aws_subnet.private_data_subnets[*].id
}

