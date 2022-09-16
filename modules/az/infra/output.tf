output "cluster_endpoint" {
  value     = azurerm_kubernetes_cluster.haacs_k8s.kube_config.0.host
}

output "cluster_certificate" {
  value     = azurerm_kubernetes_cluster.haacs_k8s.kube_config.0.cluster_ca_certificate
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.haacs_k8s.kube_config.0.client_certificate
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.haacs_k8s.kube_config.0.client_key
}

output "loadbalancer_ip" {
  value = azurerm_public_ip.ingress_ip.ip_address
}

output "loadbalancer_resource_group" {
  value = azurerm_public_ip.ingress_ip.resource_group_name
}
