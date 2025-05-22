output "namespace" {
  value = kubernetes_namespace.this.metadata[0].name
}

output "cert_manager" {
  value = helm_release.cert_manager
}
