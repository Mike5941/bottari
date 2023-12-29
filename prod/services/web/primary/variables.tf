data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "terraform-wonsoong"
    key    = "stage/database/mysql/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
