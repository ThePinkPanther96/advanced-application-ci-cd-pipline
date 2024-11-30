# VPC
variable "aws_region" {
  description = "AWS region for the resources"
  type        = string
  default     = "eu-central-1"
}

variable "subnet_id" {
  description = "The subnet ID to be used for resources"
  type        = string
  default     = "subnet-0272110df0f4edc49"
}

variable "vpc_id" {
  description = "VPC ID for the load balancer and target group"
  type        = string
  default     = "vpc-01726edb057271e76"
}


# SSL CERTIFICATE
variable "certificate_arn" {
  description = "ARN of the SSL certificate for the HTTPS listener"
  type        = string
  default     = "arn:aws:acm:eu-central-1:021891580761:certificate/b2ecec70-c917-429b-b7a0-a8cae01fdca7"
}

# SSL policy type
variable "ssl_policy" {
  description = "SSL Certificate ssl policy type"
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}


# LAUNCH TEMPLATE
variable "launch_template_security_group_ids" {
  description = "List of security group IDs to be attached to instances"
  type        = list(string)
  default     = ["sg-05fdb8cfd574907c5"]
}

variable "launch_template_name" {
  description = "Name of the Launch Template"
  type        = string
  default     = "test-tf-launch_template"
}

variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
  default     = "ami-0e04bcbe83a83792e"
}

# Key Pair Name
variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
  default     = "frankfurt-pem"
}


# ALB
variable "alb_public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
  default     = ["subnet-0272110df0f4edc49","subnet-012e5706c23f128d1"]
}

variable "alb_security_group_ids" {
  description = "List of security group IDs to be attached to a load balancer"
  type        = list(string)
  default     = ["sg-05ab7b301e7ef9133"]
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "test-tf-alb"
}


# TARGET GROUP 
variable "target_group_name" {
  description = "Name for the Target Group"
  type        = string
  default     = "tf-test-lb-tg"
}

variable "target_group_health_check_path" {
  description = "Target group health check path"
  type        = string
  default     = "/"
}

variable "target_group_listener_port" {
  description = "Target group listener port bumber"
  type        = string
  default     = "5001"
}

variable "target_group_protocol" {
  description = "Tarhet group network protocol"
  type        = string
  default     = "HTTP"
}
