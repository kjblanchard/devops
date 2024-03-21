module "flask_deployment" {
  source          = "../../modules/deployment"
  image_name      = "enf3rno/sg_wedding"
  image_tag       = "2"
  deployment_name = "flask-wedding"
  ports = [
    {
      container_port = 80
      name           = "http"
    }
  ]
}
module "flask_service" {
  source          = "../../modules/service"
  service_name      = "flask-service"
  service_selector       = "flask-wedding"
  service_type = "ClusterIP"
  ports = [
    {
      port = 80
targetPort = 8080
      name           = "http"
    }
  ]
}
