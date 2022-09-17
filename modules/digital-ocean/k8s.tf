data digitalocean_kubernetes_versions "k8s_versions" {}

resource "digitalocean_kubernetes_cluster" "k8s_haacs" {
  name    = var.cluster_name
  region  = var.region
  version = data.digitalocean_kubernetes_versions.k8s_versions.latest_version
  tags    = ["haacs"]

  node_pool {
    name       = "${var.cluster_name}-default-pool"
    size       = var.node_size
    node_count = var.min_node_count
    auto_scale = true
    min_nodes  = var.min_node_count
    max_nodes  = var.max_node_count
    tags       = ["haacs"]
  }

  lifecycle {
    ignore_changes = [
      node_pool.0.node_count,
    ]
  }
}

resource "local_file" "kubeconfig" {
  filename = "./kube/config"
  content  = digitalocean_kubernetes_cluster.k8s_haacs.kube_config.0.raw_config
}
