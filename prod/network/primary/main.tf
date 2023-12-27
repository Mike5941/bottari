terraform {
  backend "s3" {
    bucket = "terraform-wonsoong"
    key    = "stage/network/primary/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "terraform-wonsoong"
    encrypt        = true
  }
}

module "primary" {
  source = "../../../modules/network"

  project_name   = "primary"
  vpc_cidr = "10.1.0.0/16"


  server_arn = "arn:aws:acm:ap-northeast-2:675481538193:certificate/102a031f-0292-44be-825a-5001b0c517a7"
  client_arn = "arn:aws:acm:ap-northeast-2:675481538193:certificate/9a11f97f-ebb1-4020-bc55-923a9e14bd4d"
}

