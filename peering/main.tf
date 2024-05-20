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
    key            = "peering/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "fwd-cloudsec-locks"
  }
}

module "vpc_peering" {
  source  = "cloudposse/vpc-peering/aws"
  version = ">=1.0.0"

  auto_accept                               = true
  requestor_allow_remote_vpc_dns_resolution = true
  acceptor_allow_remote_vpc_dns_resolution  = true
  requestor_vpc_id                          = data.aws_vpc.vpc_new_york.id
  acceptor_vpc_id                           = data.aws_vpc.vpc_new_jersey.id
  create_timeout                            = "5m"
  update_timeout                            = "5m"
  delete_timeout                            = "10m"

  # context = module.this.context
}