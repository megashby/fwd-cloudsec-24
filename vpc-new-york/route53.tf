resource "aws_route53_zone" "sqs_phz" {
  name = "sqs.${data.aws_region.current.name}.amazonaws.com"

  vpc {
    vpc_id = module.vpc.vpc_id
  }

  lifecycle {
    ignore_changes = [vpc]
  }
}

resource "aws_route53_record" "sqs_phz_record" {
  zone_id = aws_route53_zone.sqs_phz.zone_id
  name    = "sqs.${data.aws_region.current.name}.amazonaws.com"
  type    = "A"

  alias {
    #TODO: Fix this is bad, and check that this is actually right
    name                   = module.vpc_endpoints.endpoints.sqs.dns_entry[0].dns_name
    zone_id                = module.vpc_endpoints.endpoints.sqs.dns_entry[0].hosted_zone_id
    evaluate_target_health = true
  }

}