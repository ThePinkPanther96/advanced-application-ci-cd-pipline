resource "aws_lb_target_group" "app_tg" {
  port     = var.target_group_listener_port  
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id
  name     = var.target_group_name

  health_check {
    path                = var.target_group_health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    protocol            = var.target_group_protocol
    port                = var.target_group_listener_port
  }

  tags = {
    Environment = "production"
  }
}