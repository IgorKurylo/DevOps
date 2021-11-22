resource "aws_cloudwatch_metric_alarm" "cloud_watch_alarm" {
  alarm_name          = "${var.project}-request_count_per_target_alarm"
  metric_name         = "RequestCountPerTarget"
  statistic           = "Sum"
  evaluation_periods  = 1
  period              = "60"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.alarm_sns_topic.arn]
  namespace           = "AWS/ApplicationELB"
  alarm_description   = "Alarm when come request to container"
  comparison_operator = "GreaterThanThreshold"
  threshold           = 0
  dimensions = {
    TargetGroup = aws_alb_target_group.alb_target_grp.arn_suffix
  }
}
