data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "new_jersey_ec2" {
  ami                      = data.aws_ami.amzn-linux-2023-ami.id
  iam_instance_profile = aws_iam_instance_profile.iam_profile.name
  instance_type            = "t2.micro"
  subnet_id                = module.vpc.private_subnets[0]
  vpc_security_group_ids   = [resource.aws_security_group.ec2_sg.id]

  tags = {
    Name = "new-jersey-ec2"
  }

}