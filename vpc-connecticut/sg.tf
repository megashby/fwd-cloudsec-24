resource "aws_security_group" "ec2_sg" {
  name        = "vpc-connecticut-ec2-sg"
  description = "Security group for EC2 in VPC connecticut"
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

resource "aws_security_group" "lambda_sg" {
  name        = "vpc-connecticut-lambda-sg"
  description = "Security group for lambda in VPC connecticut"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_lambda" {
  security_group_id = aws_security_group.lambda_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_vpc_lambda" {
  for_each = toset(module.vpc.private_subnets_cidr_blocks)

  security_group_id = aws_security_group.lambda_sg.id
  cidr_ipv4   = each.key
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}