variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_prefix" {
  description = "CIDR prefix for subnets"
  type        = string
  default     = "10.0"
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "alb_name" {
  description = "Name for the ALB"
  type        = string
  default     = "foodie-alb"
}

variable "target_group_name" {
  description = "Name for the target group"
  type        = string
  default     = "foodie-tg"
}

variable "listener_port" {
  description = "Port for the ALB listener"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "Protocol for the ALB listener"
  type        = string
  default     = "HTTP"
}

variable "listener_action_type" {
  description = "Action type for the ALB listener"
  type        = string
  default     = "forward"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  default     = "foodie-cluster"
}

variable "ecs_task_family" {
  description = "Family name for ECS task definition"
  default     = "foodie-task"
}

variable "ecs_task_cpu" {
  description = "CPU units for ECS task"
  default     = "256"
}

variable "ecs_task_memory" {
  description = "Memory for ECS task"
  default     = "512"
}

variable "ecs_image_url" {
  description = "ECR image URL for ECS task"
  default     = "243699833421.dkr.ecr.us-east-1.amazonaws.com/foodie-app:v7"
}

variable "ecs_container_port" {
  description = "Container port for ECS task"
  default     = 8080
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  default     = "foodie-service"
}

variable "ecs_desired_count" {
  description = "Desired number of ECS tasks"
  default     = 2
}

variable "ecs_launch_type" {
  description = "Launch type for ECS service"
  default     = "FARGATE"
}

variable "ecs_log_group_name" {
  description = "Log group name for ECS tasks"
  default     = "foodie-logs"
}

variable "ecs_log_stream_prefix" {
  description = "Log stream prefix for ECS tasks"
  default     = "foodie"
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  default     = 2
}

variable "map_public_ip_on_launch" {
  description = "Map public IP on launch for subnets"
  default     = true
}

variable "internet_route_cidr" {
  description = "CIDR block for internet route"
  default     = "0.0.0.0/0"
}

variable "alb_ingress_from_port" {
  description = "Ingress from port for ALB security group"
  default     = 80
}

variable "alb_ingress_to_port" {
  description = "Ingress to port for ALB security group"
  default     = 80
}

variable "alb_ingress_protocol" {
  description = "Ingress protocol for ALB security group"
  default     = "tcp"
}

variable "alb_ingress_cidr" {
  description = "Ingress CIDR block for ALB security group"
  default     = "0.0.0.0/0"
}

variable "alb_egress_from_port" {
  description = "Egress from port for ALB security group"
  default     = 0
}

variable "alb_egress_to_port" {
  description = "Egress to port for ALB security group"
  default     = 0
}

variable "alb_egress_protocol" {
  description = "Egress protocol for ALB security group"
  default     = "-1"
}

variable "alb_egress_cidr" {
  description = "Egress CIDR block for ALB security group"
  default     = "0.0.0.0/0"
}

variable "ecs_ingress_from_port" {
  description = "Ingress from port for ECS security group"
  default     = 8080
}

variable "ecs_ingress_to_port" {
  description = "Ingress to port for ECS security group"
  default     = 8080
}

variable "ecs_ingress_protocol" {
  description = "Ingress protocol for ECS security group"
  default     = "tcp"
}

variable "ecs_egress_from_port" {
  description = "Egress from port for ECS security group"
  default     = 0
}

variable "ecs_egress_to_port" {
  description = "Egress to port for ECS security group"
  default     = 0
}

variable "ecs_egress_protocol" {
  description = "Egress protocol for ECS security group"
  default     = "-1"
}

variable "ecs_egress_cidr" {
  description = "Egress CIDR block for ECS security group"
  default     = "0.0.0.0/0"
}

variable "iam_role_name" {
  description = "Name of the IAM role for ECS task execution"
  default     = "ecsTaskExecutionRole"
}

variable "ecs_task_execution_policy_arn" {
  description = "Policy ARN for ECS task execution"
  default     = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

variable "alb_internal" {
  description = "Whether the ALB is internal"
  default     = false
}

variable "alb_type" {
  description = "Type of the ALB"
  default     = "application"
}

variable "target_group_port" {
  description = "Port for the target group"
  default     = 8080
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  default     = "HTTP"
}

variable "target_group_type" {
  description = "Type of the target group"
  default     = "ip"
}

variable "target_group_health_path" {
  description = "Health check path for the target group"
  default     = "/"
}

variable "target_group_health_interval" {
  description = "Health check interval for the target group"
  default     = 30
}

variable "target_group_health_timeout" {
  description = "Health check timeout for the target group"
  default     = 5
}

variable "target_group_health_healthy_threshold" {
  description = "Healthy threshold for the target group"
  default     = 2
}

variable "target_group_health_unhealthy_threshold" {
  description = "Unhealthy threshold for the target group"
  default     = 2
}

variable "target_group_health_matcher" {
  description = "Health check matcher for the target group"
  default     = "200"
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  default     = "foodie-app"
}

variable "container_name" {
  description = "Name of the container"
  default     = "foodie-container"
}

variable "ecs_assign_public_ip" {
  description = "Assign public IP to ECS tasks"
  default     = true
}

variable "ecs_log_retention_days" {
  description = "Retention period for ECS log group"
  default     = 7
}

variable "image_tag" {
  description = "Docker image tag from CI/CD"
  type        = string
}