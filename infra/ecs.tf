resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "app" {
  family                   = var.ecs_task_family
  requires_compatibilities = var.ecs_requires_compatibilities
  cpu                      = var.ecs_task_cpu
  memory                   = var.ecs_task_memory

  network_mode       = var.ecs_network_mode
  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    # 🔹 MAIN APPLICATION CONTAINER
    {
      name  = var.container_name
      image = "${local.ecr_repository_url}:${var.image_tag}"

      essential = true

      portMappings = [
        {
          containerPort = var.ecs_container_port
          hostPort      = var.ecs_container_port
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.ecs_log_group_name
          awslogs-region        = var.region
          awslogs-stream-prefix = var.ecs_log_stream_prefix
        }
      }
    },

    # 🔥 NEW RELIC SIDECAR (FULLY CONFIGURED)
    {
      name      = "newrelic-infra"
      image     = var.newrelic_image
      essential = false

      # 🔐 Secure license key from SSM
      secrets = [
        {
          name      = "NRIA_LICENSE_KEY"
          valueFrom = var.newrelic_ssm_param_path
        }
      ]

      # 🔥 Full observability config
      environment = [
        {
          name  = "NRIA_DISPLAY_NAME"
          value = var.newrelic_display_name
        },
        {
          name  = "NRIA_OVERRIDE_HOST_ROOT"
          value = var.newrelic_override_host_root
        },
        {
          name  = "NRIA_IS_FORWARD_ONLY"
          value = var.newrelic_is_forward_only
        },
        {
          name  = "NRIA_CUSTOM_ATTRIBUTES"
          value = var.newrelic_custom_attributes
        },
        {
          name  = "NRIA_PASSTHROUGH_ENVIRONMENT"
          value = "ECS_CONTAINER_METADATA_URI"
        },
        {
          name  = "NRIA_ENABLE_PROCESS_METRICS"
          value = var.newrelic_enable_process_metrics
        }
      ]

      # ✅ Add logs for visibility (important!)
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.ecs_log_group_name
          awslogs-region        = var.region
          awslogs-stream-prefix = "newrelic"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn

  # 🔥 Autoscaling baseline
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

  # 🔥 Prevent downtime during deployments
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent
}