resource "aws_alb" "ecs_alb" {
  name            = "${var.project}-load-balancer-${var.environment}"
  subnets         = aws_subnet.public_subnet.*.id
  security_groups = [aws_security_group.alb_security_grp.id]
  tags = {
    environment = var.environment
  }
}
resource "aws_alb_target_group" "alb_target_grp" {
  name        = "${var.project}-alb-target-grp"
  port        = var.application_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.app_vpc.id
  target_type = "ip"
  health_check {
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }
}
resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.ecs_alb.id
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.alb_target_grp.arn
    type             = "forward"
  }
}
