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
    NGiNX = "1.29.4"
  }
  tags = ["nginx:${TAG}"]
}

target "php" {
  context = "./php"
  dockerfile = "Dockerfile"
  args = {
    CRV = "2.9.2"
    PHPV = "8.5.1-fpm"
    MEMV = "3.4.0"
  }
  tags = ["php:${TAG}"]
}