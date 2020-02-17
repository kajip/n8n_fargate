// ECS定義

locals {
  ecs_task_family = "service"
  ecs_task_cpu    = 256
  ecs_task_memory = 512

  desired_count = 1
}


resource "aws_ecs_task_definition" "n8n" {
  family = local.ecs_task_family
  container_definitions = templatefile("task-definitions/n8n.json", {
    container_name = var.service_name,
    log_group_name = var.cloudwatch_log_group_name,
    n8n_port       = var.n8n_port
  })
  cpu                = local.ecs_task_cpu
  memory             = local.ecs_task_memory
  execution_role_arn = module.iam_role_n8n_ecs_task_execution.arn
  requires_compatibilities = [
    "EC2",
    "FARGATE"
  ]
  network_mode = "awsvpc"
}

resource "aws_ecs_cluster" "n8n" {
  name = var.service_name
}

resource "aws_ecs_service" "n8n" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.n8n.id
  task_definition = aws_ecs_task_definition.n8n.arn
  launch_type     = "FARGATE"
  desired_count   = local.desired_count
  network_configuration {
    subnets = var.subnets
    security_groups = [
      aws_security_group.n8n.id
    ]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.n8n.arn
    container_name   = var.service_name
    container_port   = var.n8n_port
  }
}
