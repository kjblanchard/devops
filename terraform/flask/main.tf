module "flask_deployment" {
  source          = "../modules/deployment"
  image_name      = "enf3rno/sg_flask"
  image_tag       = "131"
  deployment_name = "flask-wedding"
  ports = [
    {
      container_port = 80
      name           = "http"
    }
  ]
}
