output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.custom_vpc.vpc_id
}

output "security_group_id" {
  description = "The ID of the security group."
  value       = module.custom_vpc.security_group_id
}

output "public_subnet_ids" {
  description = "The IDs of the created public subnets"
  value       = module.custom_vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of the created private application subnets"
  value       = module.custom_vpc.private_subnet_ids
}

output "container_subnet_id" {
  description = "The ID of the created container subnet"
  value       = module.custom_vpc.container_subnet_id
}

output "nacl_id" {
  value = module.custom_vpc.nacl_id
}