provider "aws" {
  region = "us-west-2"
}

resource "aws_launch_template" "foo" {
  name = "foo"

  vpc_security_group_ids = ["sg-12345678"]
  
  image_id = "ami-test"
  
  ebs_optimized = true
  
  instance_initiated_shutdown_behavior = "terminate"
  
  instance_type = "t2.micro"
  
  key_name = "test"
  

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
  }

  placement {
    availability_zone = "us-west-2a"
  }

  ram_disk_id = "test"

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

  user_data = filebase64("${path.module}/example.sh")
}