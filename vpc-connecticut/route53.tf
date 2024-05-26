resource "aws_route53_zone_association" "secondary" {
  zone_id = data.aws_route53_zone.sqs_phz.zone_id
  vpc_id  = module.vpc.vpc_id
}