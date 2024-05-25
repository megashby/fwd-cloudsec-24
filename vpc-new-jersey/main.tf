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
    bucket         = "fwd-cloudsec-remote-state"
    key            = "vpc-new-jersey/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "fwd-cloudsec-locks"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">=5.0.0"

  name = "vpc-new-jersey"
  cidr = "10.1.0.0/16"

  create_igw = false

  azs             = ["us-west-2a", "us-west-2b"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
  public_subnets  = ["10.1.3.0/24", "10.1.4.0/24"]

  private_subnet_tags = {
    "Tier": "Private"
  }

}
