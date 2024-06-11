terraform {
  cloud {
    organization = "Cloud-Platform"
    workspaces {
      name = "terraform-aws-vpc"
    }
  }
}
