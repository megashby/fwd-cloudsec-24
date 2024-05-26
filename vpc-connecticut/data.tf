data "aws_route53_zone" "sqs_phz" {
  name         = "sqs.${data.aws_region.current.name}.amazonaws.com."
  private_zone = true
}