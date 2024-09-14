provider "aws" {
  region = "eu-central-1"
}

data "aws_subnet" "example_subnet" {
  id = "subnet-0272110df0f4edc49"
}

resource "aws_launch_template" "asg_template" {
  name = "asg_template"

  vpc_security_group_ids = ["sg-013d218ef198ff5dd", "sg-05fdb8cfd574907c5"]
  
  image_id = "ami-0e04bcbe83a83792e"
  
  instance_initiated_shutdown_behavior = "terminate"
  
  instance_type = "t2.micro"
  
  key_name = "frankfurt-pem"

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
  }

  #placement {
  #   availability_zone = "eu-central-1a"
  # }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test-template"
    }
  }

  user_data = filebase64("${path.module}/example.sh")
}