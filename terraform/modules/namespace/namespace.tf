resource "kubernetes_namespace" "namespace_module" {
  metadata {
    name = "terraform-example-namespace"
  }
}