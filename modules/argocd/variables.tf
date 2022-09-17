variable "oidc_key" {
  type        = string
  description = "The client secret for ArgoCD in the oidc server"
  sensitive   = true
}

variable "ingress_domain" {
  type        = string
  description = "The root domain for the ingress. This will be used to create the ingress host for the argocd server"
}
