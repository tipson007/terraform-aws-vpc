locals {
  public_subnet_cidr_blocks = [
    var.public_subnet_az1_cidr,
    var.public_subnet_az2_cidr
  ]

  private_app_subnet_cidr_blocks = [
    var.private_app_subnet_az1_cidr,
    var.private_app_subnet_az2_cidr
  ]

  private_data_subnet_cidr_blocks = [
    var.private_data_subnet_az1_cidr,
    var.private_data_subnet_az2_cidr
  ]

  environment_name = var.environment_type != null ? "${var.environment}-${var.environment_type}" : var.environment
}
