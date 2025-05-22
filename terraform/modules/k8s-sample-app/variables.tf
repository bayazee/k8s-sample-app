variable "environments" {
  type = map(object({
    namespace  = string
    path       = string  # for dev: "/dev", for prod: "/"
    secret     = string  # secret message or reference
  }))
  description = "Deployment environments with their specific configuration"
}