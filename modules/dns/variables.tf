variable "digitalocean_token" {
  type      = string
  sensitive = true
}

variable "dns_domain" {
  type = string
}

variable "dns_ip" {
  type = string
}
