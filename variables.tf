variable "region" {
  description = "The AWS region where the VPC and its subnets will be created."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = ""
}

variable "igw" {
  description = "The name of the Internet Gateway"
  default     = {}
}

variable "public_subnet_cidr" {
  description = "CIDR block for the second public subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "private_subnet_cidr" {
  description = "CIDR block for the first private app subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "container_subnet_cidr" {
  description = "CIDR block for the container subnet"
  type        = string
  default     = "10.0.7.0/24"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "nat_gateway" {
  description = "Name for the NAT Gateway"
  type        = string
  default     = "nat-gateway"
}

variable "enable_nat_gateway" {
  description = "Flag to enable/disable NAT Gateway"
  type        = bool
  default     = false
}

variable "nat_eip" {
  description = "The name of the NAT Elastic IP"
  default     = false
}

variable "nacl" {
  description = "The name of the Network ACL"
  default     = {}
}

variable "security_group" {
  description = "The name of the Security Group"
  default     = {}
}

variable "environment" {
  description = "The environment (e.g., dev, stg, prod)"
  type        = string
}

variable "environment_type" {
  description = "The environment type (optional)"
  type        = string
  default     = null
}

variable "enable_public_subnets" {
  description = "Flag to enable public subnets"
  default     = true
}

variable "enable_private_subnets" {
  description = "Flag to enable private app subnets"
  default     = true
}

variable "enable_container_subnet" {
  description = "Flag to enable container subnet"
  default     = true
}

variable "enable_ingress" {
  description = "Enable or disable ingress rules"
  type        = bool
  default     = true
}

variable "enable_egress" {
  description = "Enable or disable egress rules"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Additional tags to be applied to the VPC and subnets"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "General tags to be applied to resources"
  type        = map(string)
  default     = {}
}
