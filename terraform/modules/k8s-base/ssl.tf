resource "helm_release" "ssl" {
  name             = "ssl"
  namespace        = var.ssl_namespace
  create_namespace = false

  # Charts should be in a helm repository and not a local path
  repository = "${path.module}/../../../charts/"
  chart      = "ssl"
  wait       = true
}
