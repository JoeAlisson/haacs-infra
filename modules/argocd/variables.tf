variable "oidc_key" {
  type        = string
  description = "The client secret for ArgoCD in the oidc server"
  sensitive   = true
}

variable "ingress_domain" {
  type        = string
  description = "The root domain for the ingress. This will be used to create the ingress host for the argocd server"
}

variable "tls_secret" {
  description = "The name of the secret containing the TLS certificate for the ingress"
  type        = string
  default     = ""
}

variable "enable_certificate" {
  description = "Enable the creation of a certificate for the ingress"
  type        = bool
  default     = true
}

variable "cert_manager_issuer" {
  type        = string
  description = "The cert-manager issuer to use for the argocd server"
  default     = "letsencrypt"
}

variable "apps_repository" {
  description = "The repository containing the ArgoCD apps to deploy"
  type        = string
  default     = "https://github.com/haa-criticals/apps.git"
}

variable "apps_repository_targetRevision" {
  description = "The target revision for the apps repository"
  type        = string
  default     = "main"
}

variable "apps_repository_path" {
  description = "The path to the apps directory in the apps repository"
  type        = string
  default     = "apps"
}
