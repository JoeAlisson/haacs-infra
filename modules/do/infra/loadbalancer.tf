resource "digitalocean_loadbalancer" "k8s-ingress" {
  name   = "${var.k8s_name}-ingress"
  region = var.k8s_region

  forwarding_rule {
    entry_port      = 80
    entry_protocol  = "http"
    target_port     = 80
    target_protocol = "http"
  }

  lifecycle {
    ignore_changes = [
      forwarding_rule,
      name,
    ]


  }

}
