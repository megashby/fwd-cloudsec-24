module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = ">=5.0.0"

  vpc_id = module.vpc.vpc_id

  create_security_group      = true
  security_group_name_prefix = "vpc-new-york-vpc-endpoints-"
  security_group_description = "VPC endpoint security group"
  security_group_rules = {
    ingress_https = {
      description = "HTTPS from VPC"
      cidr_blocks = data.aws_vpc.vpc[*].cidr_block
    }
  }
  endpoints = {
    sqs = {
      service             = "sqs"
      private_dns_enabled = false
      subnet_ids          = module.vpc.private_subnets
    }
  }
}