terraform {
  required_version = ">= 1.0.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74.1"
    }
  }
}

provider "aws" {
  region  = "us-east-2"
}