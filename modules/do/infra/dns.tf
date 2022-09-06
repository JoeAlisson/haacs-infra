resource "digitalocean_domain" "k8s_ingress_domain" {
  name = var.k8s_ingress_domain
}

resource "digitalocean_record" "root" {
  domain = digitalocean_domain.k8s_ingress_domain.name
  name   = "@"
  type   = "A"
  value  = digitalocean_loadbalancer.k8s-ingress.ip
  ttl    = 1800
}

resource "digitalocean_record" "asterisk" {
  domain = digitalocean_domain.k8s_ingress_domain.name
  name   = "*"
  type   = "CNAME"
  value  = "@"
  ttl    = 1800
}
