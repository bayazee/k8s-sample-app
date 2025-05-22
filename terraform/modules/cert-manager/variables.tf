variable "namespace" {
  type        = string
  description = "The namespace in which to deploy cert-manager"
  default     = "cert-manager"
}

variable "helm_repo" {
  type        = string
  description = "The Helm repository for Traefik"
  default     = "https://charts.jetstack.io"

}

variable "chart_name" {
  type        = string
  description = "The name of the Helm chart"
  default     = "cert-manager"

}

variable "chart_version" {
  type        = string
  description = "The version of the Helm chart to use"
  default     = "1.17.2"
}
