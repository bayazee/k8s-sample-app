resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace
    labels = {
      name = var.namespace,
      environment = "production"
      "app.kubernetes.io/managed-by" = "Terraform"
    }
  }
  
}