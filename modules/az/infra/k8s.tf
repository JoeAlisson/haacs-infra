data "azurerm_kubernetes_service_versions" "current" {
  location = var.az_region
}

resource "azurerm_resource_group" "haacs" {
  name     = var.az_resource_group
  location = var.az_region
}

resource "azurerm_kubernetes_cluster" "haacs_k8s" {
  name                = var.k8s_name
  location            = azurerm_resource_group.haacs.location
  resource_group_name = azurerm_resource_group.haacs.name
  dns_prefix          = "haacs"
  kubernetes_version = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${azurerm_resource_group.haacs.name}-nodes"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.az_vm_size
    zones = [1,2,3]
    enable_auto_scaling = true
    min_count = 1
    max_count = 3
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "local_file" "kubeconfig" {
  filename = "./kube/config"
  content = azurerm_kubernetes_cluster.haacs_k8s.kube_config_raw
}
