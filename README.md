## Terraform Module: VPC with NAT Gateway, EIP, NACL, and Security Group

This Terraform module provisions a Virtual Private Cloud (VPC) on AWS along with a NAT Gateway, Elastic IP (EIP), Network Access Control List (NACL), and Security Group.

### Prerequisites

- Terraform installed locally
- AWS credentials configured

### Usage

1. Clone the repository:

```bash
git clone https://github.com/yourusername/terraform-vpc-module.git
cd terraform-vpc-module
```

2. Create a `main.tf` file in your project directory and include the following code:

```hcl
module "vpc_with_nat" {
  source = "./terraform-vpc-module"

  # Specify variables here, if any
  vpc_cidr                = "10.0.0.0/16"
  public_subnet_cidr_blocks     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_app_subnet_cidr_blocks  = ["10.0.3.0/24"]
  private_data_subnet_cidr_blocks = ["10.0.4.0/24"]
  container_subnet_cidr      = "10.0.5.0/24"
  environment_name        = "test"
}
```

3. Initialize the Terraform configuration:

```bash
terraform init
```

4. Preview the changes Terraform will make:

```bash
terraform plan
```

5. Apply the changes:

```bash
terraform apply
```

### Inputs

- `vpc_cidr` (required): The CIDR block for the VPC.
- `public_subnet_cidr_blocks` (required): List of CIDR blocks for the public subnets.
- `private_app_subnet_cidr_blocks` (required): List of CIDR blocks for the private application subnets.
- `private_data_subnet_cidr_blocks` (required): List of CIDR blocks for the private data subnets.
- `container_subnet_cidr` (required): CIDR block for the container subnet.
- `environment_name` (required): Name of the environment (used for resource naming).

### Outputs

- `vpc_id`: The ID of the VPC created.
- `public_subnet_ids`: The IDs of the public subnets created.
- `private_app_subnet_ids`: The IDs of the private application subnets created.
- `private_data_subnet_ids`: The IDs of the private data subnets created.
- `container_subnet_id`: The ID of the container subnet created.
- `nat_gateway_id`: The ID of the NAT Gateway created.
- `nat_eip_id`: The ID of the Elastic IP (EIP) associated with the NAT Gateway.
- `nacl_id`: The ID of the Network Access Control List (NACL) created.
- `security_group_id`: The ID of the Security Group created.

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Issues

For any issues or feature requests, please open an issue on [GitHub](https://github.com/yourusername/terraform-vpc-module/issues).


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_security_groups"></a> [security\_groups](#module\_security\_groups) | ../modules/security_group | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../modules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_subnet_cidr"></a> [container\_subnet\_cidr](#input\_container\_subnet\_cidr) | CIDR block for the container subnet | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name | `string` | n/a | yes |
| <a name="input_environment_type"></a> [environment\_type](#input\_environment\_type) | The environment type (optional) | `string` | `null` | no |
| <a name="input_private_app_subnet_az1_cidr"></a> [private\_app\_subnet\_az1\_cidr](#input\_private\_app\_subnet\_az1\_cidr) | The CIDR block for the private app subnet in AZ1 | `string` | n/a | yes |
| <a name="input_private_app_subnet_az2_cidr"></a> [private\_app\_subnet\_az2\_cidr](#input\_private\_app\_subnet\_az2\_cidr) | The CIDR block for the private app subnet in AZ2 | `string` | n/a | yes |
| <a name="input_private_data_subnet_az1_cidr"></a> [private\_data\_subnet\_az1\_cidr](#input\_private\_data\_subnet\_az1\_cidr) | The CIDR block for the private data subnet in AZ1 | `string` | n/a | yes |
| <a name="input_private_data_subnet_az2_cidr"></a> [private\_data\_subnet\_az2\_cidr](#input\_private\_data\_subnet\_az2\_cidr) | The CIDR block for the private data subnet in AZ2 | `string` | n/a | yes |
| <a name="input_public_subnet_az1_cidr"></a> [public\_subnet\_az1\_cidr](#input\_public\_subnet\_az1\_cidr) | The CIDR block for the public subnet in AZ1 | `string` | n/a | yes |
| <a name="input_public_subnet_az2_cidr"></a> [public\_subnet\_az2\_cidr](#input\_public\_subnet\_az2\_cidr) | The CIDR block for the public subnet in AZ2 | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where the VPC and its subnets will be created. | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block for the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_app_subnet_ids"></a> [private\_app\_subnet\_ids](#output\_private\_app\_subnet\_ids) | n/a |
| <a name="output_private_data_subnet_ids"></a> [private\_data\_subnet\_ids](#output\_private\_data\_subnet\_ids) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
