data "aws_iam_policy_document" "sqs_policy_allow_all_except_connecticut_vpc" {
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
      values   = [data.aws_vpc.vpc_connecticut.id]
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


# data "aws_iam_policy_document" "sqs_policy_only_allow_pennsylvania_vpc" {
#   statement {
#     effect    = "Allow"
#     actions   = ["*"]
#     resources = ["*"]
#     principals {
#       type        = "*"
#       identifiers = ["*"]
#     }
#     condition {
#       test     = "StringEqualsIgnoreCase"
#       variable = "aws:Ec2InstanceSourceVpc"
#       values   = [data.aws_vpc.vpc_pennsylvania.id]
#     }
#   }
# }

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

data "aws_iam_policy_document" "sqs_policy_principal_tags" {
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
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalTag/VPC_ID"
      values   = [data.aws_vpc.vpc_pennsylvania.id]
    }
    // to prevent other IAM principals (users, federated users, and accounts)
    condition {
        test     = "StringEquals"
        variable = "aws:PrincipalType"
        values   = ["AssumedRole"]
    }
    // to prevent other IAM instance profiles from utilizing this path.
    condition {
        test     = "StringNotLike"
        variable = "aws:userid"
        values   = ["*:i-*"]
    }
  }

}