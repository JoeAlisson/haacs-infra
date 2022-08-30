variable "do_token" {
  type = string
  sensitive = true
}

variable "k8s_name" {
  type = string
  default = "haacs-k8s"
}
variable "k8s_region" {
  type = string
  default = "nyc1"
}
variable "k8s_node_size" {
  type = string
  default = "s-2vcpu-2gb"
}
variable "k8s_node_count" {
  type = number
  default = "3"
}
variable "k8s_node_auto_scale" {
  type = bool
  default = "true"
}
variable "k8s_min_nodes" {
  type = number
  default = "2"
}
variable "k8s_max_nodes" {
  type = number
  default = "5"
}
