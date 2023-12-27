variable "db_remote_state_key" {
  type = string
  default = "stage/database/mysql/terraform.tfstate"
}

variable "db_remote_state_bucket" {
  type = string
  default = "terraform-wonsoong"
}

data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = var.db_remote_state_bucket
    key = var.db_remote_state_key
    region = "ap-northeast-2"
  }
}