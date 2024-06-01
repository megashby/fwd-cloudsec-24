resource "aws_security_group" "ec2_sg" {
  name        = "vpc-pennsylvania-ec2-sg"
  description = "Security group for EC2 in VPC pennsylvania"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ec2" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_vpc_ec2" {
  for_each = toset(module.vpc.private_subnets_cidr_blocks)

  security_group_id = aws_security_group.ec2_sg.id
  # cidr_ipv4         = module.vpc.vpc_cidr_block
  cidr_ipv4   = each.key
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_security_group" "lambda_sg" {
  name        = "vpc-pennsylvania-lambda-sg"
  description = "Security group for lambda in VPC pennsylvania"
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