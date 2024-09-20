provider "aws" {
  region = "eu-central-1"
}

resource "aws_lb_target_group" "test" {
    port     = 80
    name     = "tf-test-lb-tg"
    protocol = "HTTP"
    vpc_id   = aws_vpc.main.id
    health_check {
      path = "/"
      interval = 30
      timeout = 5
      healthy_threshold = 5
      unhealthy_threshold = 2
      protocol = "HTTP"
    }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

