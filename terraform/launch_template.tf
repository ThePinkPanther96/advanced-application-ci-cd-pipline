provider "aws" {
  region = var.aws_region
}

data "aws_subnet" "example_subnet" {
  id = var.subnet_id
}

resource "aws_launch_template" "asg_template" {
  name = var.launch_template_name

  vpc_security_group_ids = var.launch_template_security_group_ids
  
  image_id = var.ami_id
  
  instance_initiated_shutdown_behavior = "terminate"
  
  instance_type = "t2.micro"
  
  key_name = var.key_name

  update_default_version = true
  
  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size           = 10
      delete_on_termination = true
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = data.aws_subnet.example_subnet.id
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test-template"
    }
  }

  user_data = filebase64("${path.module}/user_data.sh")
}