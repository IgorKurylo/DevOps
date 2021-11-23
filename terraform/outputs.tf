# output value of ALB DNS Name
output "alb_dns_name" {
  value = module.application.alb_endpoint
}
# output value of SNS Topic
output "sns_topic_arn" {
  value = module.application.sns_topic
}
