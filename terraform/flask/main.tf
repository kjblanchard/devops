resource "kubernetes_deployment" "flask_deployment" {
  metadata {
    name      = "flask-deployment"
    labels = {
      app = "flask-deployment"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "flask-webapp"
      }
    }
    template {
      metadata {
        labels = {
          app = "flask-webapp"
        }
      }
      spec {
        container {
          image = "enf3rno/sg_flask:dev"
          name  = "flask-webapp"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
