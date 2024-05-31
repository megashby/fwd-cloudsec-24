data "aws_vpcs" "all_vpcs" {}

data "aws_vpc" "vpc" {
  count = length(data.aws_vpcs.all_vpcs.ids)
  id    = tolist(data.aws_vpcs.all_vpcs.ids)[count.index]
}

data "aws_vpc" "vpc_new_jersey" {
  tags = { "Name" : "vpc-new-jersey" }
}

data "aws_vpc" "vpc_pennsylvania" {
  tags = { "Name" : "vpc-pennsylvania" }
}