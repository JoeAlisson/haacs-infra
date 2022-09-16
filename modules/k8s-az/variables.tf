variable "az_client_id" {
  type = string
}
variable "az_client_secret" {
  type      = string
  sensitive = true
}
variable "az_tenant_id" {
  type = string
}
variable "az_subscription_id" {
  type = string
}
variable "letsencrypt_email" {
  type = string
}

variable "argocd_oauth_key" {
  type      = string
  sensitive = true
}
variable "k8s_ingress_domain" {
  type = string
}

variable "digitalocean_token" {
  type      = string
  sensitive = true
}
