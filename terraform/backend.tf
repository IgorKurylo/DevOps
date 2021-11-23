# config terraform backend in s3 for remote state (side-notes: the bucket should created before `terraform init` command)
terraform {
  backend "s3" {
    bucket = "terraform-state-app"
    region = "eu-west-1"
    key    = "application/terraform.tfstate"
  }
}
