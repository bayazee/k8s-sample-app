resource "kubernetes_namespace" "this" {
  metadata {
    name = "poo"
    labels = {
      name ="poo"
    }
  }
  
}