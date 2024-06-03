data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2" {
  name               = "instance-role-new-jersey"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json

  tags = {
    VPC_ID = "vpc-vpc-01bd33f77a7043dff" // vpc-connecticut to demonstrate `sqs_policy_principal_tags`
  }
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "sqs_policy" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

resource "aws_iam_instance_profile" "iam_profile" {
  name = "ec2-profile-new-jersey"
  role = aws_iam_role.ec2.name

  tags = {
    VPC_ID = "vpc-vpc-01bd33f77a7043dff" // vpc-connecticut to demonstrate `sqs_policy_principal_tags`
  }
}   