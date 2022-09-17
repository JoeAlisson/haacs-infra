variable "digitalocean_token" {
  type        = string
  description = "This is the DO API token."
  sensitive   = true
}

variable "dns_domain" {
  type = string
  description = "The name of the domain."
}

variable "dns_ip" {
  type = string
  description = "The IP address of the record A in the root domain."
}
