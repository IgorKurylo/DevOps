output "alb_endpoint" {
  value = aws_alb.ecs_alb.dns_name
}
output "sns_topic" {
  value = aws_sns_topic.alarm_sns_topic.arn
}
