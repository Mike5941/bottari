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
  alias  = "secondary"
}

module "secondary" {
  source = "../../../modules/network"

  providers = {
    aws = aws.secondary
  }

  project_name = "WEB-Secondary"
  vpc_cidr     = "10.2.0.0/16"

  server_arn = "arn:aws:acm:ap-northeast-1:617669297376:certificate/12bf8dab-93a5-403f-8599-a424e9d9cb27"
  client_arn = "arn:aws:acm:ap-northeast-1:617669297376:certificate/6ab02bf1-0011-4665-a746-708828fde921"
}

