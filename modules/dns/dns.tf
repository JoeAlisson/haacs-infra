data "digitalocean_domain" "domain" {
  name = var.dns_domain
}

resource "digitalocean_record" "root" {
  domain = data.digitalocean_domain.domain.name
  name   = "@"
  type   = "A"
  value  = var.dns_ip
  ttl    = 300
}

resource "digitalocean_record" "asterisk" {
  domain = data.digitalocean_domain.domain.name
  name   = "*"
  type   = "A"
  value  = var.dns_ip
  ttl    = 300
}

output "fqdn" {
  value = digitalocean_record.root.fqdn
}
