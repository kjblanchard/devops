resource "kubernetes_deployment" "k8s_deployment" {
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
          name  = "${var.deployment_name}"
          port {
            container_port = "${var.container_port}"
          }
          dynamic "volume_mount"{
              for_each = var.volume_mounts
              content {
                  mount_path = volume_mount.mount_path
                  name = volume_mount.name
              }
          }
        }
      }
    }
  }
}