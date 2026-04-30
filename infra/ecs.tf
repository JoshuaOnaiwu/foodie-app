resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "app" {
  family                   = var.ecs_task_family
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_task_cpu
  memory                   = var.ecs_task_memory

  network_mode = "awsvpc"

  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name  = var.container_name
      image = "${local.ecr_repository_url}:${var.image_tag}"

      portMappings = [
        {
          containerPort = var.ecs_container_port
          hostPort      = var.ecs_container_port
        }
      ]

      essential = true

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.ecs_log_group_name
          awslogs-region        = var.region
          awslogs-stream-prefix = var.ecs_log_stream_prefix
        }
      }
    },

    # 🔥 NEW RELIC SIDECAR (ADDED)
    {
      name      = "newrelic-infra"
      image     = var.newrelic_image
      essential = false

      secrets = [
        {
          name      = "NRIA_LICENSE_KEY"
          valueFrom = var.newrelic_ssm_param_path
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn

  # 🔥 IMPORTANT FOR AUTOSCALING
  desired_count = var.ecs_desired_count

  launch_type = var.ecs_launch_type

  enable_ecs_managed_tags = true
  propagate_tags          = "SERVICE"

  network_configuration {
    subnets          = aws_subnet.public[*].id
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = var.ecs_assign_public_ip
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = var.container_name
    container_port   = var.ecs_container_port
  }
}