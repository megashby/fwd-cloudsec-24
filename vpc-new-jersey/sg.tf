resource "aws_security_group" "ec2_sg" {
  name        = "vpc-new-jersey-ec2-sg"
  description = "Security group for EC2 in VPC new jersey"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_vpc" {
  for_each = toset(module.vpc.private_subnets_cidr_blocks)

  security_group_id = aws_security_group.ec2_sg.id
  # cidr_ipv4         = module.vpc.vpc_cidr_block
  cidr_ipv4   = each.key
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}