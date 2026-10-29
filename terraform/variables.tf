variable "aws_region" {
  description = "AWS region where resources are created"
  type        = string
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Name prefix used for all resources (lowercase letters, numbers, hyphens)"
  type        = string
  default     = "jenkins-terraform-demo"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
