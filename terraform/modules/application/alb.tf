resource "aws_alb" "ecs_alb" {
  name            = "${var.project}-load-balancer"
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.alb_security_grp.id]
}
resource "aws_alb_target_group" "alb_target_grp" {
  name        = "${var.project}-alb-target-grp"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.app_vpc.id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
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
  port              = var.application_port
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.alb_target_grp.arn
    type             = "forward"
  }
}
