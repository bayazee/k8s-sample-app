resource "helm_release" "traefik" {
  name             = "traefik"
  namespace        = resource.kubernetes_namespace.this.metadata[0].name
  create_namespace = false
  repository       = var.helm_repo
  chart            = var.chart_name
  version          = var.chart_version
  wait             = false
  values           = [file("${path.module}/../../../charts/traefik/values.yaml")]
}
