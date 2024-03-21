locals {
  deployment_vars = read_terragrunt_config(find_in_parent_folders("deployment.hcl"))
  account_id      = local.deployment_vars.locals.account_id
  deployment_tf_state_bucket = local.deployment_vars.locals.tf_state_bucket
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "${local.deployment_tf_state_bucket}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "${local.deployment_tf_state_bucket}-lock"
  }
}
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region              = "${local.deployment_vars.locals.aws_region}"
  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = ["${local.deployment_vars.locals.account_id}"]
}
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "${local.deployment_vars.locals.k8s_context}"
}
EOF
}

inputs = merge(
  local.deployment_vars.locals,
)