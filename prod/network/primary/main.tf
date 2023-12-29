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

  project_name = "primary"
  vpc_cidr     = "10.1.0.0/16"


#  server_arn = "arn:aws:acm:ap-northeast-2:617669297376:certificate/b713dd9e-c8c5-4672-a2f2-1fbbd24a1ecd"
#  client_arn = "arn:aws:acm:ap-northeast-2:617669297376:certificate/bc24aba4-1aa7-4bb8-9c78-a7786b5703a6"
}

