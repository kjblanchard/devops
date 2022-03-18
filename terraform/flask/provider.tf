# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
provider "aws" {
  region              = "us-east-1"
  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = ["145035066069"]
}
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}