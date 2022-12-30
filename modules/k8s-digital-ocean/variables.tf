variable "do_token" {
  sensitive   = true
  description = "This is the DO API token."
  type        = string
}

variable "argocd_oauth_key" {
  type        = string
  sensitive   = true
  description = "The client secret for ArgoCD in the oidc server"
  default     = ""
}

variable "k8s_ingress_domain" {
  type        = string
  description = "The name of the domain to be used to access the cluster's ingress controller."
}

variable "letsencrypt_email" {
  type        = string
  description = "Email address for Let's Encrypt certificate registration."
}

variable "cluster_name" {
  type        = string
  description = "The name of the Kubernetes Cluster to create."
  default     = "haacs-k8s"
}
