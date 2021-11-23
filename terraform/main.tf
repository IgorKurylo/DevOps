# use with application module, pass all variables
module "application" {
  source                     = "./modules/application"
  environment                = local.environment
  region                     = local.region
  cidr_block                 = local.config.cidr_block
  az_count                   = local.config.az_count
  project                    = local.config.project
  image                      = local.config.image
  application_port           = local.config.application_port
  fargate_cpu                = local.config.fargate_cpu
  fargate_memory             = local.config.fargate_memory
  desired_count              = local.config.desired_count
  subscription_email_address = local.config.subscription_email_address
}
