output "cluster_token" {
  value = digitalocean_kubernetes_cluster.k8s_haacs.kube_config.0.token
}

output "cluster_endpoint" {
  value = digitalocean_kubernetes_cluster.k8s_haacs.endpoint
}

output "cluster_certificate" {
  value = digitalocean_kubernetes_cluster.k8s_haacs.kube_config.0.cluster_ca_certificate
}

output "client_certificate" {
  value = digitalocean_kubernetes_cluster.k8s_haacs.kube_config.0.client_certificate
}

output "load_balancer_ip" {
  value = digitalocean_loadbalancer.k8s-ingress.ip
}

output "load_balancer_id" {
  value = digitalocean_loadbalancer.k8s-ingress.id
}
