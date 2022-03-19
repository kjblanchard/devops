variable "image_name" {
  type        = string
  description = "The image that should be used when building the image."
}

variable "image_tag" {
  type        = string
  description = "The tag that should be used when building the image"
}

variable "deployment_name" {
  type        = string
  description = "The deployment name for this deployment, used for naming things properly"
}
variable "container_port" {
  type        = number
  description = "The port that the container will have open"
}

variable "volume_mounts" {
  type = list(object({
    mount_path = string,
    name = string
  }))
  default = null
  description = "The volume mounts to use"
}
variable "ports" {
  type = list(object({
    container_port = number,
    name = string
  }))
  default = null
  description = "The volume mounts to use"
}
    # re_addresses = replace(jsonencode({for i in range(local.az_num) :
    #   local.az_names[i] => {
    #     "egress-ipv4"  = local.re_eg_eip[i].public_ip,
    #     "ingress-ipv4" = local.re_ing_eip[i].public_ip