// IAM定義

module "iam_role_n8n_ecs_task_execution" {
  source = "../../modules/iam/role/service"

  name = "n8n-ecs-task-execution-role"
  principals = [
    "ecs-tasks.amazonaws.com"
  ]
}

resource "aws_iam_role_policy_attachment" "n8n_ecs_task_role_policy" {
  role       = module.iam_role_n8n_ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
