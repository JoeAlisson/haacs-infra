variable "do_token" {
  type        = string
  description = "This is the DO API token."
  sensitive   = true
}

variable "cluster_name" {
  type        = string
  description = "The name of the Kubernetes Cluster to create."
  default     = "haacs-k8s"
}

variable "region" {
  type        = string
  description = "The slug identifier for the region where the Kubernetes cluster will be created."
  default     = "nyc1"
}

variable "node_size" {
  type        = string
  description = "he slug identifier for the type of Droplet to be used as workers in the node pool"
  default     = "s-2vcpu-2gb"
}

variable "min_node_count" {
  type        = number
  description = "The minimum number of nodes which should exist in this Node Pool."
  default     = "2"
}

variable "max_node_count" {
  type        = number
  description = "The maximum number of nodes which should exist in this Node Pool."
  default     = "5"
}
