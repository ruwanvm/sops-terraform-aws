terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "ruwanvm"
}
