resource "digitalocean_loadbalancer" "k8s-ingress" {
  name   = "${var.cluster_name}-ingress"
  region = var.region

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
