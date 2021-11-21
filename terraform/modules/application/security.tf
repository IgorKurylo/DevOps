resource "aws_security_group" "alb_security_grp" {
  name        = "${var.project}-load-balancer-sg"
  description = "access to the ALB"
  vpc_id      = aws_vpc.app_vpc.id
  ingress {
    protocol    = "tcp"
    from_port   = var.application_port
    to_port     = var.application_port
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Environment = var.environment
  }
}
resource "aws_security_group" "ecs_tasks_security_grp" {
  name        = "${var.project}-ecs-tasks-sg"
  description = "allow inbound traffict from ALB only"
  vpc_id      = aws_vpc.app_vpc.id
  ingress {
    protocol        = "tcp"
    from_port       = var.application_port
    to_port         = var.application_port
    security_groups = [aws_security_group.alb_security_grp.id]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
