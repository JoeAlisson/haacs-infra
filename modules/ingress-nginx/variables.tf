variable "cluster_host" {
  type        = string
  description = "The hostname (in form of URI) of the Kubernetes API."
}
variable "cluster_token" {
  type        = string
  description = "(Optional) The bearer token to use for authentication when accessing the Kubernetes API."
  sensitive   = true
  default     = ""
}
variable "cluster_ca_certificate_b64" {
  type        = string
  description = "PEM-encoded root certificates bundle for TLS authentication."
  sensitive   = true
}

variable "client_certificate" {
  type        = string
  sensitive   = true
  description = "(Optional) PEM-encoded client certificate for TLS authentication."
  default     = ""
}

variable "client_key" {
  type        = string
  description = "(Optional) PEM-encoded client certificate key for TLS authentication. "
  sensitive   = true
  default     = ""
}

variable "provider_loadbalancer_annotation" {
  type        = string
  description = "The annotation key to use for Cloud Provider to bind a load balancer to ingress controller."
  default     = "terraform"
}

variable "provider_loadbalancer_annotation_value" {
  type        = string
  description = "The annotation value to use for Cloud Provider to bind a load balancer to ingress controller."
  default     = "ingress"
}

variable "loadBalancer_ip" {
  type        = string
  description = "The IP address of the load balancer to be used in ingress controller."
  default     = ""
}
