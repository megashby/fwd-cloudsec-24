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
  name               = "instance-role-connecticut"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json

  tags = {
    VPC_ID = "vpc-003fff33a6f745e85" // vpc-pennsylvania to demonstrate `sqs_policy_principal_tags`
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
  name = "ec2-profile-connecticut"
  role = aws_iam_role.ec2.name

  tags = {
    VPC_ID = "vpc-003fff33a6f745e85" // vpc-pennsylvania to demonstrate `sqs_policy_principal_tags`
  }
}