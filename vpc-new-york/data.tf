data "aws_vpcs" "all_vpcs" {}

data "aws_vpc" "vpc" {
  count = length(data.aws_vpcs.all_vpcs.ids)
  id    = tolist(data.aws_vpcs.all_vpcs.ids)[count.index]
}