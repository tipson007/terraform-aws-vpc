variable "region" {
  type        = string
  description = "The AWS region where the VPC and its subnets will be created."
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "environment" {
  description = "The environment name"
  type        = string
}

variable "environment_type" {
  description = "The environment type (optional)"
  type        = string
  default     = null
}


variable "public_subnet_az1_cidr" {
  description = "The CIDR block for the public subnet in AZ1"
  type        = string
}

variable "public_subnet_az2_cidr" {
  description = "The CIDR block for the public subnet in AZ2"
  type        = string
}

variable "private_app_subnet_az1_cidr" {
  description = "The CIDR block for the private app subnet in AZ1"
  type        = string
}

variable "private_app_subnet_az2_cidr" {
  description = "The CIDR block for the private app subnet in AZ2"
  type        = string
}

variable "private_data_subnet_az1_cidr" {
  description = "The CIDR block for the private data subnet in AZ1"
  type        = string
}

variable "private_data_subnet_az2_cidr" {
  description = "The CIDR block for the private data subnet in AZ2"
  type        = string
}

variable "container_subnet_cidr" {
  description = "CIDR block for the container subnet"
  type        = string
}