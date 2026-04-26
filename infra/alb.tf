resource "aws_lb" "app" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = var.alb_type
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public[*].id
}

resource "aws_lb_target_group" "app" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = aws_vpc.main.id
  target_type = var.target_group_type

  health_check {
    path                = var.target_group_health_path
    interval            = var.target_group_health_interval
    timeout             = var.target_group_health_timeout
    healthy_threshold   = var.target_group_health_healthy_threshold
    unhealthy_threshold = var.target_group_health_unhealthy_threshold
    matcher             = var.target_group_health_matcher
  }
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = var.listener_action_type
    target_group_arn = aws_lb_target_group.app.arn
  }
}

