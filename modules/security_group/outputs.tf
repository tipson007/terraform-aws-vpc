output "region" {
  description = "The region of the VPC"
  value       = var.region
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.my_security_group.id
}

output "security_group_name" {
  description = "The name of the created security group."
  value       = aws_security_group.my_security_group.name
}

output "security_group_description" {
  description = "The description of the created security group."
  value       = aws_security_group.my_security_group.description
}

output "ingress_rules" {
  description = "The ingress rules of the security group."
  value       = aws_security_group.my_security_group.ingress
}

output "egress_rules" {
  description = "The egress rules of the security group."
  value       = aws_security_group.my_security_group.egress
}

