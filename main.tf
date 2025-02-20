terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"  # For Windows
}

resource "docker_image" "flask_app" {
  name         = "flask-devsecops"
  keep_locally = false
}

resource "docker_container" "flask_container" {
  name  = "flask-app"
  image = docker_image.flask_app.image_id
  ports {
    external = 5001  # Change from 5000 to 5001
    internal = 5000
    ip       = "0.0.0.0"
    protocol = "tcp"
  }
}
