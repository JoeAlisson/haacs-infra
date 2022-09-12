variable "cluster_host" {
  type = string
}
variable "cluster_token" {
  type      = string
  sensitive = true
  default   = ""
}
variable "cluster_ca_certificate_b64" {
  type      = string
  sensitive = true
}

variable "client_certificate" {
  type      = string
  sensitive = true
  default   = ""
}

variable "client_key" {
  type      = string
  sensitive = true
  default   = ""
}

variable "provider_loadbalancer_annotation" {
  type    = string
  default = "terraform"
}

variable "provider_loadbalancer_annotation_value" {
  type    = string
  default = "ingress"
}

variable "loadBalancer_ip" {
  type = string
  default = ""
}
