resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project}-ecs-cluster"
}
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.project}-${var.environment}-app-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.app_task_definition_tpl.rendered
}

data "template_file" "app_task_definition_tpl" {
  template = (file("${path.module}/templates/task_definition.json.tpl"))
  vars = {
    name             = "${var.project}-${var.environment}-application"
    image            = var.image
    application_port = var.application_port
    fargate_cpu      = var.fargate_cpu
    fargate_memory   = var.fargate_memory
    region           = var.region
  }
}
resource "aws_ecs_service" "ecs_service" {
  name            = "${var.project}-${var.environment}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks_security_grp.id]
    subnets          = aws_subnet.private_subnet.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.alb_target_grp.id
    container_name   = "${var.project}-${var.environment}-application"
    container_port   = var.application_port
  }

  depends_on = [aws_alb_listener.alb_listener, aws_iam_role_policy_attachment.ecs_task_execution_role]
}
