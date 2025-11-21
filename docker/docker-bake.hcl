variable "TAG" {
  default = "latest"
}

group "default" {
  targets = ["nginx", "php"]
}

target "nginx" {
  context = "./nginx"
  dockerfile = "Dockerfile"
  args = {
    NGiNX = "1.29.3"
  }
  tags = ["nginx:${TAG}"]
}

target "php" {
  context = "./php"
  dockerfile = "Dockerfile"
  args = {
    CRV = "2.9.2"
    PHPV = "8.4.15-fpm"
    MEMV = "3.4.0"
  }
  tags = ["php:${TAG}"]
}