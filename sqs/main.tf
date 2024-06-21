provider "aws" {
  region = "us-west-2"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.30.0"
    }
  }

  backend "s3" {
    bucket         = "" #configure your provider here
    key            = "sqs/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "" #configure your provider here
  }
}

module "sqs" {
  source  = "terraform-aws-modules/sqs/aws"
  version = ">=4.0.0"

  name = "my-sqs-queue"
}