module "flask_deployment" {
  source          = "../../modules/deployment"
  image_name      = "enf3rno/sg_nginx"
  #image_tag       = "2"
  image_tag       = "27"
  deployment_name = "nginx-wedding"
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
      volume_name  = "cert-volume"
      path_on_node = "/kube_host/letsencrypt"
    },
    {
      volume_name  = "acme-volume"
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
}
module "flask_service" {
  source          = "../../modules/service"
  service_name      = "nginx-service"
  service_selector       = "nginx-wedding"
  service_type = "NodePort"
  node_ports = [
    {
      port = 80
      name           = "http"
      node_port = 30007
    },
    {
      port = 443
      name           = "https"
      node_port = 30008
    }
  ]
}
