terraform {

  backend "remote" {
    organization = "<value_from_terraform>"
    workspaces {
      name = "<create_in_terraform>"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  required_version = ">= 0.13.0"
}
