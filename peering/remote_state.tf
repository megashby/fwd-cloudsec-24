data "aws_vpc" "vpc_new_york" {
  tags = { "Name" : "vpc-new-york" }
}

data "aws_vpc" "vpc_new_jersey" {
  tags = { "Name" : "vpc-new-jersey" }
}