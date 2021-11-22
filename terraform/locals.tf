locals {
  # environment name set by terraform workspace (workspace = env)
  environment = terraform.workspace
  # region
  region = "eu-west-1"

  config_map = {
    dev   = local.dev_config
    stage = local.stage_config
    # prod  = local.prod_config
  }
  config = lookup(local.config_map, local.environment)
}
