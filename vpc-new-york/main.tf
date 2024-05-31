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
    key            = "vpc-new-york/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "fwd-cloudsec-locks"
  }
}

data "aws_region" "current" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">=5.0.0"

  name = "vpc-new-york"
  cidr = "10.0.0.0/16"

  create_igw = false

  azs             = ["us-west-2a", "us-west-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  private_subnet_tags = {
    "Tier" : "Private"
  }

}

resource "aws_route" "new-york-tgw-route" {
  for_each = toset(module.vpc.private_route_table_ids)

  route_table_id         = each.key
  destination_cidr_block = "10.2.0.0/16"           //CIDR for vpc-connecticut
  transit_gateway_id     = "tgw-0146b27a407532707" // TGW-ID 
}

