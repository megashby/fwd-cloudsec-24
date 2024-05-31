data "aws_vpc" "vpc_new_york" {
  tags = { "Name" : "vpc-new-york" }
}

data "aws_vpc" "vpc_new_jersey" {
  tags = { "Name" : "vpc-new-jersey" }
}

data "aws_vpc" "vpc_connecticut" {
  tags = { "Name" : "vpc-connecticut" }
}

data "aws_vpc" "vpc_pennsylvania" {
  tags = { "Name" : "vpc-pennsylvania" }
}

data "aws_subnets" "new_york_private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_new_york.id]
  }
  tags = {
    Tier = "Private"
  }
}

data "aws_subnets" "connecticut_private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_connecticut.id]
  }
  tags = {
    Tier = "Private"
  }
}