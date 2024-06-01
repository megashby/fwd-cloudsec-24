data "aws_iam_policy_document" "sqs_policy_allow_all_except_new_jersey_vpc" {
  statement {
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "StringEqualsIgnoreCase"
      variable = "aws:Ec2InstanceSourceVpc"
      values   = [data.aws_vpc.vpc_new_jersey.id]
    }
  }

  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}


data "aws_iam_policy_document" "sqs_policy_only_allow_pennsylvania_vpc" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "StringEqualsIgnoreCase"
      variable = "aws:Ec2InstanceSourceVpc"
      values   = [data.aws_vpc.vpc_pennsylvania.id]
    }
  }
}

data "aws_iam_policy_document" "allow_from_only_private_subnets" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "ForAnyValue:StringEqualsIgnoreCase"
      variable = "aws:Ec2InstanceSourceVpc"
      values   = data.aws_vpc.vpc[*].id
    }
    condition {
      test     = "ForAnyValue:IpAddress"
      variable = "aws:Ec2InstanceSourcePrivateIPv4"
      values   = data.aws_subnet.subnet[*].cidr_block
    }
  }
}