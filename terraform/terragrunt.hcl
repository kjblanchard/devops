locals {
  # Automatically load deployment variables
  deployment_vars = read_terragrunt_config(find_in_parent_folders("deployment.hcl"))
  account_id      = local.deployment_vars.locals.account_id

  # # Automatically load area variables
  # area_vars = read_terragrunt_config(find_in_parent_folders("area.hcl"))

  # # Automatically load version variables
  # version_vars = read_terragrunt_config(find_in_parent_folders("version.hcl"))

  # # Automatically load region variables
  # region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  # aws_region  = local.region_vars.locals.aws_region

  deployment_tf_state_bucket = local.deployment_vars.locals.tf_state_bucket
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    # Deployment controls the Terraform state bucket
    bucket         = "${local.deployment_tf_state_bucket}"
    # key reflects folder heirachy
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "${local.deployment_tf_state_bucket}-lock"
  }
}

# terraform_version_constraint  = "=0.13.6"
# terragrunt_version_constraint = "=0.25.2"

# Generate an AWS provider block
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

# These variables are passed as inputs to all leaf terragrunt.hcl
inputs = merge(
  local.deployment_vars.locals,
  # local.area_vars.locals,
  # local.version_vars.locals,
  # local.region_vars.locals,
)