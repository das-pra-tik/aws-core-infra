AWS VPC Terraform module
Terraform module which creates VPC resources on AWS

Usage
module "vpc" {
  source = "git::https://github.com/das-pra-tik/aws-core-infra.git//VPC?ref=1.4.0"

  name     = "my-vpc"
  vpc_cidr = "10.0.0.0/16"

  azs              = ["us-east-2a", "us-east-2b", "us-east-2c"]
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnets = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}