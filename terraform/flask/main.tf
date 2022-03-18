module "flask_deployment" {
  source          = "../modules/deployment"
  image_name      = "enf3rno/sg_flask"
  image_tag       = "dev"
  deployment_name = "flask_wedding"
  container_port  = 80
}
