terraform {
  backend "s3" {
    bucket = "terraform-state"
    key    = "application/terraform.tfstate"
  }
}
