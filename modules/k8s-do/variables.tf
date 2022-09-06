variable "do_token" {
  sensitive = true
  type      = string
}

variable "argocd_oauth_key" {
  type      = string
  sensitive = true
  default   = ""
}

variable "k8s_ingress_domain" {
  type = string
}
