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

variable "externalIps" {
  type        = string
  description = "The IP addresses of the load balancer to be used in ingress controller."
  default     = "{}"
}

variable "default_ssl_certificate" {
  description = "The default SSL certificate to use for HTTPS."
  type        = string
  default     = ""
}

variable "default_ssl_certificate_namespace" {
  description = "The namespace of the default SSL certificate to use for HTTPS."
  type        = string
  default     = ""
}
variable "default_ssl_certificate_cert_b64" {
  description = "The base64 encoded certificate of the default SSL certificate to use for HTTPS."
  type        = string
  default     = ""
  sensitive   = true
}
variable "default_ssl_certificate_key_b64" {
  description = "The base64 encoded key of the default SSL certificate to use for HTTPS."
  type        = string
  default     = ""
  sensitive   = true
}

variable "kubeconfig_path" {
  description = "The path to the kubeconfig file."
  type        = string
  default     = ""
}
