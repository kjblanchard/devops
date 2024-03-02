module "supergoon_deployment" {
  source          = "../../modules/deployment"
  image_name      = "enf3rno/sg_com"
  # image_tag       = "145"
  image_tag       = "1"
  deployment_name = "go-supergoon-com"
  ports = [
    {
      container_port = 8080
      name           = "http"
    }
  ]
}
module "flask_service" {
  source          = "../../modules/service"
  service_name      = "go-supergoon-com"
  service_selector       = "go-supergoon-com"
  service_type = "ClusterIP"
  ports = [
    {
      port = 8080
      name           = "http"
    }
  ]
}
