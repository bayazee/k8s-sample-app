resource "helm_release" "reflector" {
  name             = "reflector"
  namespace        = va.reflector_namespace
  create_namespace = false
  chart            = "oci://ghcr.io/emberstack/helm-charts/reflector"
  version          = "9.1.7"
  wait             = false
}
