module "flask_deployment" {
  source          = "../modules/deployment"
  image_name      = "enf3rno/quotegenerator"
  image_tag       = "dev"
  deployment_name = "flask"
  container_port  = 80
  volume_mounts = [
    {
      mount_path = "/etc/letsencrypt"
      name = "cert-volume"
    },
    {
      mount_path = "/var/www/challenge/.well-known/acme-challenge"
      name = "acme-volume"
    }
  ]
  ports = [
    {
      container_port = 80
      name = "http"
    },
    {
      container_port = 443
      name = "https"
    },
  ]
}
