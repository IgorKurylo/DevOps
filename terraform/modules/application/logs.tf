resource "aws_cloudwatch_log_group" "application_log_group" {
  name              = "/ecs/${var.project}-${var.environment}-application"
  retention_in_days = 30

  tags = {
    Name = "${var.project}-application-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "application_log_stream" {
  name           = "${var.project}-${var.environment}-application-log-stream"
  log_group_name = aws_cloudwatch_log_group.application_log_group.name
}
