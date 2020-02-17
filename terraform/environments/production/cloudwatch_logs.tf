// CloudWatch Logs定義

locals {
  retention_in_days = 1
}


resource "aws_cloudwatch_log_group" "n8n" {
  name              = var.cloudwatch_log_group_name
  retention_in_days = local.retention_in_days
}
