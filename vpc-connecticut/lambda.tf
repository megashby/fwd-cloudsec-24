module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "vpc-connecticut-lambda"
  description   = "Simple Lambda function in VPC connecticut"
  handler       = "index.lambda_handler"
  runtime       = "python3.12"

  source_path = "${path.module}/lambda"

  vpc_subnet_ids                     = module.vpc.private_subnets
  vpc_security_group_ids             = [aws_security_group.lambda_sg.id]

  attach_policies = true
  policies        = ["arn:aws:iam::aws:policy/AmazonSQSFullAccess", "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
  number_of_policies = 2

  tags = {
    VPC_ID = module.vpc.vpc_id
  }
}