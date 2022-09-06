variable "cluster_host" {
  type = string
}
variable "cluster_token" {
  type      = string
  sensitive = true
}
variable "cluster_ca_certificate_b64" {
  type      = string
  sensitive = true
}

variable "provider_loadbalancer_id_annotation" {
  type    = string
  default = "kubernetes\\.digitalocean\\.com/load-balancer-id"
}

variable "loadbalancer_id" {
  type = string
}
