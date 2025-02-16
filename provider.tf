terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>4"
    }
  }
}

provider "aws" {
    region = "us-east-1"
    # Fill with values or configure .aws directory
    # access_key = ""
    # secret_key = ""
    # token = ""
}