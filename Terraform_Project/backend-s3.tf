terraform {
  backend "s3" {
    bucket = "terraform-s3-backend-ak"
    key    = "terraform/backend"
    region = "eu-west-2"
  }
}

