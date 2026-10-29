locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Latest Amazon Linux 2023 image
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# Firewall: allow web traffic in, everything out
resource "aws_security_group" "web" {
  name_prefix = "${var.project_name}-web-"
  description = "Allow HTTP traffic"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

resource "aws_default_subnet" "default_az1" {
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true
}

# Web server
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = <<-EOT
    #!/bin/bash
    dnf install -y nginx
    echo "<h1>Provisioned with Terraform - Kenisha Koul</h1>" > /usr/share/nginx/html/index.html
    systemctl enable --now nginx
  EOT

  user_data_replace_on_change = true

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-web"
  })
}

# Random suffix so the bucket name is unique worldwide
resource "random_id" "suffix" {
  byte_length = 4
}

# Bucket to store build artifacts
resource "aws_s3_bucket" "artifacts" {
  bucket = "${var.project_name}-artifacts-${random_id.suffix.hex}"

  tags = local.common_tags
}
