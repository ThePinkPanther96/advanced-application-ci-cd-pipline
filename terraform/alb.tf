resource "aws_lb" "app_lb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_security_group_ids
  subnets            = var.alb_public_subnet_ids

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}
sdf

# HTTPS Listener
resource "aws_lb_listener" "app_lb_listener_HTTPS" {
    load_balancer_arn = aws_lb.app_lb.arn
    port              = 443
    protocol          = "HTTPS"
    ssl_policy        = var.ssl_policy
    certificate_arn   = var.certificate_arn

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.app_tg.arn
    }
}

## HTTP Listener
#resource "aws_lb_listener" "app_lb_listener_HTTP" {
#    load_balancer_arn = aws_lb.app_lb.arn
#    port              = 80
#    protocol          = "HTTP"
#    default_action {
#        type             = "forward"
#        target_group_arn = aws_lb_target_group.app_tg.arn
#    }
#}
