variable "az_client_id" {
  type =  string
}
variable "az_client_secret" {
  type =  string
  sensitive =  true
}
variable "az_tenant_id" {
  type = string
}
variable "az_subscription_id" {
  type = string
}
variable "az_resource_group" {
  type = string
  default = "haacs"
}
variable "az_region" {
  type = string
  default = "East US"
}

variable "k8s_name" {
  type = string
  default = "haacs_k8s"
}

variable "az_vm_size" {
  default = "Standard_DS2_v2"
}

variable "k8s_ingress_domain" {
  default = "az.joealisson.dev"
}
