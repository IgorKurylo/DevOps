locals {
  stage_config = {
    environment                = "stage"
    region                     = "eu-west-1"
    cidr_block                 = "10.10.0.0/16"
    az_count                   = 2
    project                    = "devops"
    image                      = "772417916823.dkr.ecr.eu-west-1.amazonaws.com/application:1.0"
    application_port           = 8080
    fargate_cpu                = "1024"
    fargate_memory             = "2048"
    desired_count              = 4
    subscription_email_address = "ikurylo22@gmail.com"
  }
}
