resource "aws_lb_target_group" "app_tg" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  name     = var.target_group_name

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    protocol            = "HTTP"
  }

  tags = {
    Environment = "production"
  }
}