terraform {
  backend "s3" {
    bucket = "terraform-wonsoong"
    key    = "stage/services/web/secondary/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "terraform-wonsoong"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-northeast-1"
  alias  = "secondary"
}


module "db_secrets" {
  source      = "../../../../global/secrets"
  secret_name = "MyDatabaseSecret"
}


module "secondary_webserver" {
  source = "../../../../modules/services/web"

  providers = {
    aws = aws.secondary
  }

  cluster_name         = "webservers-secondary"
  remote_state_bucket  = "terraform-wonsoong"
  vpc_remote_state_key = "stage/network/secondary/terraform.tfstate"
  private_ip           = "10.2.1.100"
  max_size = 2
  min_size = 1

  db_username = module.db_secrets.db_credentials["username"]
  db_password = module.db_secrets.db_credentials["password"]
  db_name     = data.terraform_remote_state.db.outputs.primary_dbname
  db_host     = data.terraform_remote_state.db.outputs.secondary_address
  db_port     = data.terraform_remote_state.db.outputs.secondary_port
}

