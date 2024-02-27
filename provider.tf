provider "aws" {
  region = "us-east-2"  # Specify your desired AWS region
  profile = "profile-name"
}

terraform {
  backend "s3" {
    bucket         = "<bucket-name>"
    key            = "terraform.tfstate"  # The name of your state file in the bucket
    region         = "<region-name>"  # Specify your AWS region
    encrypt        = true
    dynamodb_table = "<dynamodbtable-name>"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.1"
    }
  }
}

