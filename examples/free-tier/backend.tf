terraform {
  cloud {
    organization = "xx"
    workspaces {
      name = "terraform-aws-vpc"
    }
  }
}