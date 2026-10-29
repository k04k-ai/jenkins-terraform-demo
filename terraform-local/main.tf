terraform {
  required_version = ">= 1.5.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Windows Docker Desktop connection
provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

variable "external_port" {
  description = "Port on your laptop"
  type        = number
  default     = 8085
}

resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = true
}

resource "docker_container" "web" {
  name  = "tf-nginx"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = var.external_port
  }

  upload {
    file    = "/usr/share/nginx/html/index.html"
    content = "<h1>Provisioned with Terraform - Kenisha Koul</h1>"
  }
}

output "website_url" {
  value = "http://localhost:${var.external_port}"
}
