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

variable "argocd_oauth_key" {
  type      = string
  sensitive = true
}

variable "ingress_domain" {
  type = string
}
