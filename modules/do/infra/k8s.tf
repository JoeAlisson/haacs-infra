data digitalocean_kubernetes_versions "k8s_versions" { }

resource "digitalocean_kubernetes_cluster" "k8s_haacs" {
  name    = var.k8s_name
  region  = var.k8s_region
  version = data.digitalocean_kubernetes_versions.k8s_versions.latest_version
  tags = ["haacs"]

  node_pool {
    name = "${var.k8s_name}-default-pool"
    size = var.k8s_node_size
    node_count = var.k8s_node_count
    auto_scale = var.k8s_node_auto_scale
    min_nodes =  var.k8s_min_nodes
    max_nodes = var.k8s_max_nodes
    tags = ["haacs"]
  }

  lifecycle {
    ignore_changes = [
      node_pool.0.node_count,
    ]
  }
}

resource "local_file" "kubeconfig" {
  filename = "./kube/config"
  content = digitalocean_kubernetes_cluster.k8s_haacs.kube_config.0.raw_config
}
