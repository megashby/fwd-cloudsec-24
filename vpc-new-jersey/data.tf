data "aws_route53_zone" "sqs_phz" {
  name         = "sqs.${data.aws_region.current.name}.amazonaws.com."
  private_zone = true
}

data "aws_route53_zone" "ssm_phz" {
  name         = "ssm.${data.aws_region.current.name}.amazonaws.com."
  private_zone = true
}

data "aws_route53_zone" "ssmmessages_phz" {
  name         = "ssmmessages.${data.aws_region.current.name}.amazonaws.com."
  private_zone = true
}

data "aws_route53_zone" "ec2messages_phz" {
  name         = "ec2messages.${data.aws_region.current.name}.amazonaws.com."
  private_zone = true
}
