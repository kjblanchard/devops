resource "kubernetes_deployment" "k8s_deployment" {
  metadata {
    name = "${var.deployment_name}-deployment"
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
          #   dynamic "volume_mount"{
          #       for_each = var.volume_mounts
          #       content {
          #           mount_path = volume_mount.value.mount_path
          #           name = volume_mount.value.mount_path
          #       }
          #   }
          dynamic "volume_mount" {
            for_each = length(var.volume_mounts) > 0 ? [1] : [0]
            content {
                info = { for i in var.volume_mounts :
                info => {
                  "mount_path" = i.mount_path,
                  "name"       = i.name
                }
              }
          }
          }
        }
      }
    }
  }
}
