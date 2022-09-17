resource "azurerm_public_ip" "ingress_ip" {
  name                = "${var.cluster_name}-ingress-ip"
  location            = azurerm_resource_group.haacs.location
  resource_group_name = azurerm_kubernetes_cluster.haacs_k8s.node_resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}
