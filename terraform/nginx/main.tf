module "flask_deployment" {
  source          = "../modules/deployment"
  image_name      = "enf3rno/quotegenerator"
  image_tag       = "dev"
  deployment_name = "flask"
  container_port  = 80
}
