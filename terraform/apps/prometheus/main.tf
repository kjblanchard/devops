module "flask_deployment" {
  source          = "../../modules/namespace"
  namespace_name      = "prometheus"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "kube-prometheus-stack"

  chart      = "prometheus-community/kube-prometheus-stack"
   values = [
    "${file("values.yaml")}"
  ]
}