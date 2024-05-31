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
      variable = "aws:SourceVpc"
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
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpc"
      values   = [data.aws_vpc.vpc_pennsylvania.id]
    }
  }
}