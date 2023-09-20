data "external" "host_env_vars" {
  program = ["python", "${path.module}/main.py"]
}
locals {
  env_vars = {
    DNS_ZONES             = data.external.host_env_vars.result["DNS_ZONES"]
    ZONE_ID               = data.external.host_env_vars.result["ZONE_ID"]
    AWS_ACCESS_KEY_ID     = data.external.host_env_vars.result["AWS_ACCESS_KEY_ID"]
    AWS_SECRET_ACCESS_KEY = data.external.host_env_vars.result["AWS_SECRET_ACCESS_KEY"]
  }
}

resource "kubernetes_config_map" "my_config" {
  metadata {
    name = "my-config"
  }

  data = local.env_vars
}

resource "kubernetes_cron_job" "my_cron_job" {
  metadata {
    name = "goon-ddns"
  }

  spec {
    schedule = "0 0 * * *"

    job_template {
      metadata {
        name = "goon-ddns"
      }
      spec {
        template {
          metadata {
            name = "goon-ddns"
          }
          spec {
            container {
              name = "goon-ddns"
              image = "enf3rno/sg_ddns:2"
              env_from {
                config_map_ref {
                  name = kubernetes_config_map.my_config.metadata[0].name
                }
              }
            }
          }
        }
      }
    }
  }
}

