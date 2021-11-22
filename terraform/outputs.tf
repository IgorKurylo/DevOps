output "alb_dns_name" {
  value = module.application.alb_endpoint
}
output "sns_topic_arn" {
  value = module.application.sns_topic
}
