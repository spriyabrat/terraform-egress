provider "aws" {
  region = "us-east-2"  # Specify your desired AWS region

  access_key = "AKIA5GGMEOYVQUVUJWG4"
  secret_key = "wff8T/3U2nwq65VRysI+Ni0tXqaMnSytVi5rACWO"
}

/*
terraform {
  backend "s3" {
    bucket         = "testtoodelete321"
    key            = "terraform.tfstate"  # The name of your state file in the bucket
    region         = "us-east-2"  # Specify your AWS region
    encrypt        = true
    dynamodb_table = "terraform-state-locking"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.1"
    }
  }
}
*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.1"
    }
  }
}
