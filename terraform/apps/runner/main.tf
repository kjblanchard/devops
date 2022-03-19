module "runner_deployment" {
  source          = "../../modules/deployment"
  image_name      = "enf3rno/sg_runner"
  image_tag       = "1"
  deployment_name = "runner"
  ports = [
    {
      container_port = 80
      name           = "http"
    }
  ]
}
module "runner_service" {
  source          = "../../modules/service"
  service_name      = "runner"
  service_selector       = "runner"
  service_type = "ClusterIP"
  ports = [
    {
      port = 80
      name           = "http"
    }
  ]
}
