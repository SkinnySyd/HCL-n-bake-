variable "default_platforms" {
    default = ["linux/amd64", "linux/arm64"]
}

variable "image_tags" {
  default = {
    frontend = ["skinnysyddocker/frontend:latest"]
    frontend_cache = ["skinnysyddocker/frontend:cache"]
    backend  = ["skinnysyddocker/backend:latest"]
    backend_cache    = ["skinnysyddocker/backend:cache"] 
  }
}

group "default" {
    targets = ["build-backend", "build-frontend"]
}

group "ci" {
    targets = ["build-backend", "build-frontend"]
    no-cache = true
}

target "build-backend" {
    context = "./backend"
    dockerfile = "Dockerfile"
    tags = "${image_tags.backend}"
    
    platforms =  "${default_platforms}"

    cache-from =  ["${image_tags.backend_cache[0]}"]
    
    cache-to = ["type=registry,ref=${image_tags.backend_cache[0]},mode=push"]
}

target "build-frontend" {
    context = "./frontend"
    dockerfile = "Dockerfile"
    tags = "${image_tags.frontend}"
    
    platforms = "${default_platforms}"

    cache-from = ["${image_tags.frontend_cache[0]}"]
    
    cache-to = ["type=registry,ref=${image_tags.frontend_cache[0]},mode=push"]
}