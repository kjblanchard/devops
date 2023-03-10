locals {
  module_name     = reverse(split("/", get_terragrunt_dir()))[0]
  deployment_vars = read_terragrunt_config(find_in_parent_folders("deployment.hcl"))
}

inputs = merge(
  {},
  try(local.module_vars, {}))

include {
  path = find_in_parent_folders()
}
