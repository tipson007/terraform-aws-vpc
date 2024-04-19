terraform {
  cloud {
    organization = "Cloud-Platform"
    workspaces {
      name = "sam-aws-workspace"
    }
  }
}
