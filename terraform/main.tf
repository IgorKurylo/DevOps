module "application" {
  source                     = "./modules/application"
  cidr_block                 = local.config.cidr_block
  az_count                   = local.config.az_count
  project                    = local.config.project
  environment                = local.config.environment
  region                     = local.config.region
  image                      = local.config.image
  application_port           = local.config.application_port
  fargate_cpu                = local.config.fargate_cpu
  fargate_memory             = local.config.fargate_memory
  desired_count              = local.config.desired_count
  subscription_email_address = local.config.subscription_email_address
}
