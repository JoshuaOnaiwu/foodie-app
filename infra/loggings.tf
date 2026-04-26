resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = var.ecs_log_group_name
  retention_in_days = var.ecs_log_retention_days
}