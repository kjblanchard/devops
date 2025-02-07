module "supergoon_deployment" {
  source          = "../../modules/deployment"
  image_name      = "enf3rno/sg_com_simple"
  image_tag       = "7"
  deployment_name = "supergoon-com"
  ports = [
    {
      container_port = 80
      name           = "http"
    }
  ]
}
module "flask_service" {
  source          = "../../modules/service"
  service_name      = "supergoon-com"
  service_selector       = "supergoon-com"
  service_type = "ClusterIP"
  ports = [
    {
      port = 80
      name           = "http"
    }
  ]
}
