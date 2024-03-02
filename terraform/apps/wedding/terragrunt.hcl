locals {
  module_name     = reverse(split("/", get_terragrunt_dir()))[0]
  deployment_vars = read_terragrunt_config(find_in_parent_folders("deployment.hcl"))

  # area_vars       = read_terragrunt_config(find_in_parent_folders("area.hcl"))
  # area            = local.area_vars.locals.area

  # version_vars    = read_terragrunt_config(find_in_parent_folders("version.hcl"))
  # version_string  = local.version_vars.locals.version_string

  # region_vars     = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  # aws_region      = local.region_vars.locals.aws_region
  # dir_region      = local.region_vars.locals.dir_region

  # source_ref      = local.deployment_vars.locals.config[local.area][local.version_string][local.dir_region][local.module_name].source_ref

  # ===

  # module_vars = local.deployment_vars.locals.config[local.area][local.version_string][local.dir_region][local.module_name]
}

inputs = merge(
  {},
  try(local.module_vars, {}))

include {
  path = find_in_parent_folders()
}
