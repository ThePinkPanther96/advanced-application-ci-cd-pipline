# AWS Region
variable "aws_region" {
  description = "AWS region for the resources"
  type        = string
  default     = "eu-central-1"
}

# Subnet ID
variable "subnet_id" {
  description = "The subnet ID to be used for resources"
  type        = string
  default     = "subnet-0272110df0f4edc49"
}

# ALB Public Subnet IDs
variable "alb_public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
  default     = ["subnet-0272110df0f4edc49","subnet-012e5706c23f128d1"]
}

# AMI ID
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

# VPC ID for Target Group
variable "vpc_id" {
  description = "VPC ID for the load balancer and target group"
  type        = string
  default     = "vpc-01726edb057271e76"
}

# SSL certificate ARN for HTTPS listener
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

# Security Group IDs
variable "launch_template_security_group_ids" {
  description = "List of security group IDs to be attached to instances"
  type        = list(string)
  default     = ["sg-013d218ef198ff5dd", "sg-05fdb8cfd574907c5"]
}

variable "alb_security_group_ids" {
  description = "List of security group IDs to be attached to a load balancer"
  type        = list(string)
  default     = ["sg-05ab7b301e7ef9133"]
}

# Names
variable "launch_template_name" {
  description = "Name of the Launch Template"
  type        = string
  default     = "test-tf-launch_template"
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "test-tf-alb"
}

variable "target_group_name" {
  description = "Name for the Target Group"
  type        = string
  default     = "tf-test-lb-tg"
}