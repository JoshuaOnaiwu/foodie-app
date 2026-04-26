resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = var.alb_ingress_from_port
    to_port     = var.alb_ingress_to_port
    protocol    = var.alb_ingress_protocol
    cidr_blocks = [var.alb_ingress_cidr]
  }

  egress {
    from_port   = var.alb_egress_from_port
    to_port     = var.alb_egress_to_port
    protocol    = var.alb_egress_protocol
    cidr_blocks = [var.alb_egress_cidr]
  }
}

resource "aws_security_group" "ecs_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = var.ecs_ingress_from_port
    to_port         = var.ecs_ingress_to_port
    protocol        = var.ecs_ingress_protocol
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = var.ecs_egress_from_port
    to_port     = var.ecs_egress_to_port
    protocol    = var.ecs_egress_protocol
    cidr_blocks = [var.ecs_egress_cidr]
  }
}