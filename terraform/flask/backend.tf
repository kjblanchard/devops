# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "supergoon-wedding-terraform-state"
    dynamodb_table = "supergoon-wedding-terraform-state-lock"
    encrypt        = true
    key            = "flask/terraform.tfstate"
  }
}
