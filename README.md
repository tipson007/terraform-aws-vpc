
---

# AWS VPC Terraform Module

This Terraform module creates a fully configured Virtual Private Cloud (VPC) in AWS, complete with public and private subnets, internet gateway, NAT gateway, eip, route tables, network ACLs, and security groups.

## Features

- Creates a VPC with the specified CIDR block
- Configurable number of public and private subnets
- Optional NAT Gateway for private subnets
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
  nat_gateway                 = "my-nat-gateway"
  nat_eip                     = "my-nat-eip"
  nacl                        = "my-nacl"
  security_group              = "my-security-group"
  environment                 = "dev"
  environment_type            = "test"
  enable_public_subnets       = true
  enable_private_subnets      = true
  enable_container_subnet     = true
  enable_nat_gateway          = true
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

### aws_nat_gateway

Creates a NAT Gateway in the first public subnet, if enabled.

### aws_eip

Creates an Elastic IP for the NAT Gateway, if enabled.

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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.73 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.73 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_network_acl.nacl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl_association.public_subnet_nacl_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_association) | resource |
| [aws_network_acl_rule.inbound_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.outbound_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_route_table.public_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.public_subnet_route_table_associations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.my_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.container_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.available_zones](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones | `list(string)` | <pre>[<br>  "eu-west-1a",<br>  "eu-west-1b",<br>  "eu-west-1c"<br>]</pre> | no |
| <a name="input_container_subnet_cidr"></a> [container\_subnet\_cidr](#input\_container\_subnet\_cidr) | CIDR block for the container subnet | `string` | `"10.0.7.0/24"` | no |
| <a name="input_enable_container_subnet"></a> [enable\_container\_subnet](#input\_enable\_container\_subnet) | Flag to enable container subnet | `bool` | `true` | no |
| <a name="input_enable_egress"></a> [enable\_egress](#input\_enable\_egress) | Enable or disable egress rules | `bool` | `true` | no |
| <a name="input_enable_ingress"></a> [enable\_ingress](#input\_enable\_ingress) | Enable or disable ingress rules | `bool` | `true` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Flag to enable/disable NAT Gateway | `bool` | `false` | no |
| <a name="input_enable_private_subnets"></a> [enable\_private\_subnets](#input\_enable\_private\_subnets) | Flag to enable private app subnets | `bool` | `true` | no |
| <a name="input_enable_public_subnets"></a> [enable\_public\_subnets](#input\_enable\_public\_subnets) | Flag to enable public subnets | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment (e.g., dev, stg, prod) | `string` | n/a | yes |
| <a name="input_environment_type"></a> [environment\_type](#input\_environment\_type) | The environment type (optional) | `string` | `null` | no |
| <a name="input_igw"></a> [igw](#input\_igw) | The name of the Internet Gateway | `map` | `{}` | no |
| <a name="input_nacl"></a> [nacl](#input\_nacl) | The name of the Network ACL | `map` | `{}` | no |
| <a name="input_nat_eip"></a> [nat\_eip](#input\_nat\_eip) | The name of the NAT Elastic IP | `bool` | `false` | no |
| <a name="input_nat_gateway"></a> [nat\_gateway](#input\_nat\_gateway) | Name for the NAT Gateway | `string` | `"nat-gateway"` | no |
| <a name="input_private_subnet_cidr"></a> [private\_subnet\_cidr](#input\_private\_subnet\_cidr) | CIDR block for the first private app subnet | `list(string)` | <pre>[<br>  "10.0.2.0/24"<br>]</pre> | no |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | CIDR block for the second public subnet | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where the VPC and its subnets will be created. | `string` | n/a | yes |
| <a name="input_security_group"></a> [security\_group](#input\_security\_group) | The name of the Security Group | `map` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | General tags to be applied to resources | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC | `string` | `""` | no |
| <a name="input_vpc_tags"></a> [vpc\_tags](#input\_vpc\_tags) | Additional tags to be applied to the VPC and subnets | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | The availability zones. |
| <a name="output_container_subnet_id"></a> [container\_subnet\_id](#output\_container\_subnet\_id) | The ID of the container subnet |
| <a name="output_nacl_id"></a> [nacl\_id](#output\_nacl\_id) | The ID of the Network ACL |
| <a name="output_nat_eip_id"></a> [nat\_eip\_id](#output\_nat\_eip\_id) | The ID of the NAT Elastic IP |
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | The ID of the NAT Gateway |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | The IDs of the private app subnets |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | The IDs of the public subnets |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the Security Group |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
