resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  namespace        = resource.kubernetes_namespace.this.metadata[0].name
  create_namespace = false
  repository       = var.helm_repo
  chart            = var.chart_name
  version          = var.chart_version
  wait             = false
  skip_crds        = false
}
