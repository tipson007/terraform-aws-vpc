
---

# AWS VPC Terraform Module

This Terraform module creates a free-tier fully configured Virtual Private Cloud (VPC) in AWS, with public and private subnets, internet gateway, route tables, network ACLs, and security groups.

## Features

- Creates a VPC with the specified CIDR block
- Configurable number of public and private subnets
- Internet Gateway for public subnets
- Custom Network ACLs
- Custom Security Groups

## Requirements

- [Terraform](https://www.terraform.io/downloads.html) >= 0.12

## Usage

### Example

```hcl
module "custom_vpc" {
  source                      = "../../"
  vpc_cidr                    = "10.0.0.0/16"
  region                      = "eu-west-1"
  vpc_name                    = "my-vpc"
  igw                         = "my-igw"
  public_subnet_cidr          = ["10.0.1.0/24"]
  private_subnet_cidr         = ["10.0.2.0/24"]
  availability_zones          = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  container_subnet_cidr       = "10.0.7.0/24"
  nat_gateway                 = ""
  nat_eip                     = ""
  nacl                        = "my-nacl"
  security_group              = "my-security-group"
  environment                 = "dev"
  environment_type            = "test"
  enable_public_subnets       = true
  enable_private_subnets      = true
  enable_container_subnet     = true
  enable_nat_gateway          = false
  enable_ingress              = true
  enable_egress               = true

  vpc_tags = {
    "Department" = "Engineering"
    "Owner"      = "xx"
  }

  tags = {
    "Project" = "xx"
    "Team"    = "xx"
  }
}
```

## Resource Documentation

### aws_vpc

Creates an AWS VPC with the specified CIDR block and tags.

### aws_internet_gateway

Creates an Internet Gateway and attaches it to the VPC.

### data.aws_availability_zones

Fetches the list of available availability zones in the specified region.

### aws_subnet (Public, Private, Container)

Creates subnets (public, private, container) within the VPC, using the specified CIDR blocks and availability zones.

### aws_route_table

Creates a route table for public subnets, with a default route to the Internet Gateway.

### aws_route_table_association

Associates the public subnets with the public route table.

### aws_network_acl

Creates a Network ACL with custom inbound and outbound rules.

### aws_network_acl_rule

Creates inbound and outbound rules for the Network ACL.

### aws_network_acl_association

Associates the Network ACL with the public subnets.

### aws_security_group

Creates a security group with custom ingress and egress rules.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## Author

- [Sam O](https://github.com/tipson007)
``` 

I adjusted the documentation to reflect the absence of NAT Gateway and Elastic IP. Let me know if you need further adjustments!

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_custom_vpc"></a> [custom\_vpc](#module\_custom\_vpc) | ../../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_subnet_id"></a> [container\_subnet\_id](#output\_container\_subnet\_id) | The ID of the created container subnet |
| <a name="output_nacl_id"></a> [nacl\_id](#output\_nacl\_id) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | The IDs of the created private application subnets |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | The IDs of the created public subnets |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC. |
