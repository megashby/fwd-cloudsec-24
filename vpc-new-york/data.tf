data "aws_vpcs" "all_vpcs" {}

data "aws_vpc" "vpc" {
  count = length(data.aws_vpcs.all_vpcs.ids)
  id    = tolist(data.aws_vpcs.all_vpcs.ids)[count.index]
}

data "aws_vpc" "vpc_new_jersey" {
  tags = { "Name" : "vpc-new-jersey" }
}

data "aws_vpc" "vpc_connecticut" {
  tags = { "Name" : "vpc-connecticut" }
}

data "aws_subnets" "all_private_subnets" {
  tags = {
    Tier = "Private"
  }
}

data "aws_subnet" "subnet" {
  count = length(data.aws_subnets.all_private_subnets.ids)
  id    = tolist(data.aws_subnets.all_private_subnets.ids)[count.index]
}
