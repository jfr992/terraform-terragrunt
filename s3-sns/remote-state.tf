terraform {
  required_version = ">= 1.0.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74.1"
    }
  }
  backend "s3" {
    bucket         = "challenge-s3-tfstate"
    region         = "us-east-2"
    key            = "s3-sns/terraform.tfstate"
    dynamodb_table = "challenge-s3-tfstate-terraform-lock"
  }
}