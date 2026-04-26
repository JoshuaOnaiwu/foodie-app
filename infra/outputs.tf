output "alb_dns_name" {
  description = "ALB DNS Name"
  value       = aws_lb.app.dns_name
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "Public Subnet IDs"
  value       = aws_subnet.public[*].id
}

output "security_group_id" {
  description = "ECS Security Group ID"
  value       = aws_security_group.ecs_sg.id
}

output "ecr_repository_url" {
  description = "ECR Repo URL (use this in GitHub Actions)"
  value       = local.ecr_repository_url
}

output "ecs_cluster_name" {
  description = "ECS Cluster Name"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "ECS Service Name"
  value       = aws_ecs_service.app.name
}

output "task_definition_arn" {
  description = "Task Definition ARN"
  value       = aws_ecs_task_definition.app.arn
}

output "ecs_task_execution_role_arn" {
  description = "IAM Role ARN for ECS Task Execution"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "app_access_hint" {
  description = "How to access your app"
  value       = "App is accessible via ALB at http://${aws_lb.app.dns_name}"
}