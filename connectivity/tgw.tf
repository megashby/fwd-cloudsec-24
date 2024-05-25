module "tgw" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = ">=2.0.0"

  name      = "tgw-new-york-connecticut"
  share_tgw = false

  vpc_attachments = {
    vpc1 = {
      vpc_id     = data.aws_vpc.vpc_new_york.id
      subnet_ids = data.aws_subnets.new_york_private_subnets.ids
    },
    vpc2 = {
      vpc_id     = data.aws_vpc.vpc_connecticut.id
      subnet_ids = data.aws_subnets.connecticut_private_subnets.ids
    }
  }
}