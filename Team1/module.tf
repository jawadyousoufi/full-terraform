variable "region" {
    default = "us-east-1"
}


provider "aws" {
    region = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "team1"
  cidr = "10.0.0.0/16"
  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
output vpc_id {
    value = module.vpc.vpc_id
}

output public_subnets {
    value = module.vpc.public_subnets
}

output private_subnets {
    value = module.vpc.private_subnets
}