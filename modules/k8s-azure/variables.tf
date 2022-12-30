variable "azure_client_id" {
  type        = string
  description = "The Azure Client ID which should be used."
}
variable "azure_client_secret" {
  type        = string
  description = "The Azure Client Secret which should be used."
  sensitive   = true
}
variable "azure_tenant" {
  type        = string
  description = "The Azure Tenant ID which should be used."
}
variable "azure_subscription" {
  type        = string
  description = "The Azure Subscription ID which should be used."
}
variable "letsencrypt_email" {
  type        = string
  description = "Email address for Let's Encrypt certificate registration."
}

variable "cert_manager_issuer" {
  type        = string
  description = "The cert-manager issuer to use for the argocd server"
  default = "letsencrypt"
}

variable "argocd_oauth_key" {
  type        = string
  description = "The client secret for ArgoCD in the oidc server"
  sensitive   = true
  default = ""
}
variable "k8s_ingress_domain" {
  type        = string
  description = "The name of the domain to be used to access the cluster's ingress controller."
}

variable "digitalocean_token" {
  type        = string
  description = "This is the Digital Ocean API token used to create the DNS record."
  sensitive   = true
}

variable "cluster_name" {
  type        = string
  description = "The name of the Kubernetes Cluster to create."
  default     = "haacs-k8s"
}
