resource "aws_autoscaling_group" "bar" {
  availability_zones = ["eu-central-1b"]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1

  launch_template {
    name    = var.launch_template_name
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.app_tg.arn]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Environment"
    value               = "production"
    propagate_at_launch = true
  }
}