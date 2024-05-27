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
    name                   = module.vpc_endpoints.endpoints.sqs.dns_entry[0].dns_name
    zone_id                = module.vpc_endpoints.endpoints.sqs.dns_entry[0].hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_zone" "ssm_phz" {
  name = "ssm.${data.aws_region.current.name}.amazonaws.com"

  vpc {
    vpc_id = module.vpc.vpc_id
  }

  lifecycle {
    ignore_changes = [vpc]
  }
}

resource "aws_route53_record" "ssm_phz_record" {
  zone_id = aws_route53_zone.ssm_phz.zone_id
  name    = "ssm.${data.aws_region.current.name}.amazonaws.com"
  type    = "A"

  alias {

    name                   = module.vpc_endpoints.endpoints.ssm.dns_entry[0].dns_name
    zone_id                = module.vpc_endpoints.endpoints.ssm.dns_entry[0].hosted_zone_id
    evaluate_target_health = true
  }

}
resource "aws_route53_zone" "ssmmessages_phz" {
  name = "ssmmessages.${data.aws_region.current.name}.amazonaws.com"

  vpc {
    vpc_id = module.vpc.vpc_id
  }

  lifecycle {
    ignore_changes = [vpc]
  }
}

resource "aws_route53_record" "ssmmessages_phz_record" {
  zone_id = aws_route53_zone.ssmmessages_phz.zone_id
  name    = "ssmmessages.${data.aws_region.current.name}.amazonaws.com"
  type    = "A"

  alias {
    #TODO: Fix this is bad, and check that this is actually right
    name                   = module.vpc_endpoints.endpoints.ssmmessages.dns_entry[0].dns_name
    zone_id                = module.vpc_endpoints.endpoints.ssmmessages.dns_entry[0].hosted_zone_id
    evaluate_target_health = true
  }

}
resource "aws_route53_zone" "ec2messages_phz" {
  name = "ec2messages.${data.aws_region.current.name}.amazonaws.com"

  vpc {
    vpc_id = module.vpc.vpc_id
  }

  lifecycle {
    ignore_changes = [vpc]
  }
}

resource "aws_route53_record" "ec2messages_phz_record" {
  zone_id = aws_route53_zone.ec2messages_phz.zone_id
  name    = "ec2messages.${data.aws_region.current.name}.amazonaws.com"
  type    = "A"

  alias {
    #TODO: Fix this is bad, and check that this is actually right
    name                   = module.vpc_endpoints.endpoints.ec2messages.dns_entry[0].dns_name
    zone_id                = module.vpc_endpoints.endpoints.ec2messages.dns_entry[0].hosted_zone_id
    evaluate_target_health = true
  }

}