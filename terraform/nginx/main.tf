module "flask_deployment" {
  source          = "../modules/deployment"
  image_name      = "enf3rno/quotegenerator"
  image_tag       = "dev"
  deployment_name = "flask"
  container_port  = 80
  ports = [
    {
      container_port = 80
      name           = "http"
    },
    {
      container_port = 443
      name           = "https"
    },
  ]
  volume_host_path = [
    {
      volume_name  = cert-volume
      path_on_node = "/kube_host/letsencrypt"
    },
    {
      volume_name  = acme-volume
      path_on_node = "/kube_host/challenge"
    }
  ]
  volume_mount = [
    {
      mount_path  = "/etc/letsencrypt"
      volume_name = "cert-volume"
    },
    {
      mount_path  = "/var/www.challenge/.well-known/acme-challenge"
      volume_name = "acme-volume"
    },
  ]
  # volumes:
  #   - name: cert-volume
  #     hostPath:
  #       path: /kube_host/letsencrypt
  #   - name: acme-volume
  #     hostPath:
  #       path: /kube_host/challenge
}
