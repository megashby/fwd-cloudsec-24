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