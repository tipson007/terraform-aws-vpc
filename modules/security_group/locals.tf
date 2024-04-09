locals {
  environment_name = var.environment_type != null ? "${var.environment}-${var.environment_type}" : var.environment
}
