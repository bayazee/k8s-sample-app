output "namespace" {
  value = kubernetes_namespace.this.metadata[0].name
}

output "traefik" {
  value = helm_release.traefik
}
