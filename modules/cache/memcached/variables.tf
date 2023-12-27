data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket_name
    key    = var.vpc_remote_state_key
    region = local.seoul_region
  }
}


variable "cluster_id" {
  type = string
}

variable "remote_state_bucket_name" {
  type = string
  default = "terraform-wonsoong"
}

variable "vpc_remote_state_key" {
  type = string
}

locals {
  seoul_region = "ap-northeast-2"

  memcached_port = 11211
  all_protocols = "-1"

  my_ip = ["125.242.51.183/32"]
  local_ip = ["10.0.0.0/8"]
  all_ip = ["0.0.0.0/0"]
}