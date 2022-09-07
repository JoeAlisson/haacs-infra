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

variable "letsencrypt_email" {
  type = string
}
