resource "aws_route53_zone_association" "sqs" {
  zone_id = data.aws_route53_zone.sqs_phz.zone_id
  vpc_id  = module.vpc.vpc_id
}

resource "aws_route53_zone_association" "ssm" {
  zone_id = data.aws_route53_zone.ssm_phz.zone_id
  vpc_id  = module.vpc.vpc_id
}

resource "aws_route53_zone_association" "ssmmessages" {
  zone_id = data.aws_route53_zone.ssmmessages_phz.zone_id
  vpc_id  = module.vpc.vpc_id
}

resource "aws_route53_zone_association" "ec2messages" {
  zone_id = data.aws_route53_zone.ec2messages_phz.zone_id
  vpc_id  = module.vpc.vpc_id
}