terraform {
  backend "s3" {
    bucket = "terraform-state-app"
    region = "eu-west-1"
    key    = "application/terraform.tfstate"
  }
}
