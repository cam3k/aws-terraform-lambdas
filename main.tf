module "vpc" {
  source = "./vpc"
  aws_region = var.aws_region
}

module "lambda" {
  source = "./lambda"
  vpc_id = module.vpc.vpc_id
  vpc_subnet_id = module.vpc.private_subnet_id
}