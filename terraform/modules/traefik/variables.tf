variable "namespace" {
  type        = string
  description = "The namespace in which to deploy Traefik"
  default     = "traefik"
}

variable "helm_repo" {
  type        = string
  description = "The Helm repository for Traefik"
  default     = "https://helm.traefik.io/traefik"

}

variable "chart_name" {
  type        = string
  description = "The name of the Traefik Helm chart"
  default     = "traefik"

}

variable "chart_version" {
  type        = string
  description = "The version of the Traefik Helm chart to use"
  default     = "35.3.0"
}
