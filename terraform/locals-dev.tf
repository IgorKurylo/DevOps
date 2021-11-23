# dev env configuration
locals {
  dev_config = {
    cidr_block                 = "10.0.0.0/16"
    az_count                   = 2
    project                    = "homework"
    image                      = "nginxdemos/hello"
    application_port           = 80
    fargate_cpu                = "1024"
    fargate_memory             = "2048"
    desired_count              = 2
    subscription_email_address = "ikurylo22@gmail.com" # enter your email for get alarms

  }
}
