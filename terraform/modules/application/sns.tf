resource "aws_sns_topic" "alarm_sns_topic" {
  name = "${var.project}-cw-alarm-topic"
}
resource "aws_sns_topic_subscription" "alarm_sns_topic_sub" {
  topic_arn = aws_sns_topic.alarm_sns_topic.arn
  protocol  = "email"
  endpoint  = var.subscription_email_address
  endpoint_auto_confirms = true
}
