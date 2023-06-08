terraform {
  backend "s3" {
    bucket = "supergoon-terraform-plans"
    key    = "website_monitoring/terraform.tfstate"
    region = "us-east-2"
  }
}
