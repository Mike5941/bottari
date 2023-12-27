terraform {
  backend "s3" {
    bucket = "terraform-wonsoong"
    key    = "stage/network/secondary/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "terraform-wonsoong"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-northeast-1"
  alias = "secondary"
}

module "secondary" {
  source = "../../../modules/network"

  providers = {
    aws = aws.secondary
  }

  project_name   = "WEB-Secondary"
  vpc_cidr = "10.2.0.0/16"

  server_arn = "arn:aws:acm:ap-northeast-1:675481538193:certificate/d1df0001-6451-45cb-b334-7b963eed6187"
  client_arn = "arn:aws:acm:ap-northeast-1:675481538193:certificate/7c769b5a-cb0c-42bf-a6a7-3312c17f90cb"
}

