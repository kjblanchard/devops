module "flask_deployment" {
  source          = "../modules/deployment"
  image_name      = "enf3rno/sg_flask"
  image_tag       = "dev"
  deployment_name = "flask-wedding"
  container_port  = 80
}

locals{

  volume_mounts = file(yamlencode([
    {
      mount_path = "/etc/letsencrypt"
      name = "cert-volume"
    },
    {
      mount_path = "/var/www/challenge/.well-known/acme-challenge"
      name = "acme-volume"
    }
  ]))
}