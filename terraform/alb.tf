# Create an Application Load Balancer (ALB)
resource "aws_lb" "app_lb" {
    name = "app-alb"
    internal = false
    load_balancer_type = "application"
    subnets = aws_subnet.app_subnet[*].id
    security_groups = [aws_security_group.alb_sg.id]
    tags = {
        Name = "app-alb"
    }
}

# Create an HTTP listener on port 80 for the ALB
resource "aws_lb_listener" "app_lb_listener_HTTP" {
    load_balancer_arn = aws_lb.app_lb.arn
    port = "80"
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.app_tg.arn
    }
}

resource "aws_lb_listener" "app_lb_listener_HTTPS" {
    load_balancer_arn = aws_lb.app_lb.arn
    port = "443"
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.app_tg.arn
    }
}