```Usage#

module "vpc" {
source                       = "../modules/vpc"
environment                  = var.environment
environment_type             = var.environment_type
region                       = var.region
vpc_cidr                     = var.vpc_cidr
public_subnet_az1_cidr       = var.public_subnet_az1_cidr
public_subnet_az2_cidr       = var.public_subnet_az2_cidr
private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
container_subnet_cidr        = var.container_subnet_cidr
} 
```
## Modules

| Name | Source | Version |
|------|--------|---------|
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
