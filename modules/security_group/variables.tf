variable "region" {
  description = "The AWS region where the VPC and its subnets will be created."
}

variable "environment" {
  description = "The environment (e.g., dev, uat, prod)"
  type        = string
}

variable "environment_type" {
  description = "The environment type (optional)"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "The ID of the VPC where the resources will be created"
}