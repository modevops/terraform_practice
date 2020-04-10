terraform {
  backend "s3" {
    bucket = "stefan-terraform-demo"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

