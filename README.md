### Devops Homework Assignment

**Prerequisites**:

- Terraform v1.0.10
- AWS CLI (Configured and with appropriate permissions)

##### Provisioning with Terraform

1. Edit in `backend.tf` file bucket and key for remote state in s3
2. Edit in `locals.tf` file your region you want you deploy
3. Run `terraform init`
4. Run `terraform workspace new dev` (side-note: if you want a other environment run this command as `terraform workspace new {environment}`)
5. Variables Config:
   1. Edit `local-dev.tf` file with your configurations
   2. You can create a new file with other configration for provisioning new environment
      (important : need to change dev_config to {environment_config} and the file also)

`locals { dev_config = { cidr_block="cidr block for vpc" az_count="number of availability zone" project="name of project" image="docker image" application_port=container port fargate_cpu="cpu for container" fargate_memory="memory for container" desired_count=containers count subscription_email_address="email-address" } }`

6.  Run `terraform plan`
7.  Run `terraform apply` wait for finished.
    1.  Take from terraform outputs result the ALB DNS name.
    2.  Go to your email AWS send you subscribtion confirmation to sns topic
8.  Go to your internet browser and you should get the nginx info page.
9.  Wait for alert email from AWS with information about alarm, when your send request to container.
10. Run `terraform destroy` for tear down the all resource from AWS Account.
