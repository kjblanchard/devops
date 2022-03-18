resource "kubernetes_deployment" "{var.deployment_name}_deployment" {
  metadata {
    name      = "${var.deployment_name}-deployment"
    labels = {
      app = "${var.deployment_name}-deployment"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "${var.deployment_name}"
      }
    }
    template {
      metadata {
        labels = {
          app = "${var.deployment_name}"
        }
      }
      spec {
        container {
          image = "${var.image_name}:${var.image_tag}"
          name  = "${var.image_name}"
          port {
            container_port = "${var.container_port}"
          }
        }
      }
    }
  }
}