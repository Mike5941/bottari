terraform {
  backend "s3" {
    bucket = "terraform-wonsoong"
    key    = "stage/services/web/primary/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "terraform-wonsoong"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-northeast-2"
  alias = "primary"
}

provider "aws" {
  region = "ap-northeast-1"
  alias = "secondary"
}

module "db_secrets" {
  source      = "../../../../global/secrets"
  secret_name = "MyDatabaseSecret"
}

module "primary_webserver" {
  source = "../../../../modules/services/web"
  depends_on = [module.db_secrets]

  providers = {
    aws = aws.primary
  }

  cluster_name           = "webservers-primary"
  remote_state_bucket = "terraform-wonsoong"
  vpc_remote_state_key    = "stage/network/primary/terraform.tfstate"
  private_ip = "10.1.1.100"

  db_username = module.db_secrets.db_credentials["username"]
  db_password = module.db_secrets.db_credentials["password"]
  db_name = data.terraform_remote_state.db.outputs.primary_dbname
  db_host = data.terraform_remote_state.db.outputs.primary_address
  db_port = data.terraform_remote_state.db.outputs.primary_port
}

