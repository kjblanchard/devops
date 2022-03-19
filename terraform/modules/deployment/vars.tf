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

variable "volume_mount" {
  description = "(Optional) Mount path from pods to volume"
  default     = []
}
variable "volume_host_path" {
  description = "(Optional) Mount path from pods to volume"
  default     = []
}
variable "ports" {
  description = "(Optional) Mount path from pods to volume"
  default     = []
}