variable "client_id" {
  type        = string
  description = "The Azure Client ID which should be used."
}
variable "client_secret" {
  type        = string
  description = "The Azure Client Secret which should be used."
  sensitive   = true
}
variable "tenant" {
  type        = string
  description = "The Azure Tenant ID which should be used."
}
variable "subscription" {
  type        = string
  description = "The Azure Subscription ID which should be used."
}
variable "resource_group" {
  type        = string
  description = "The Name which should be used for the Resource Group. Changing this forces a new Resource Group to be created."
  default     = "haacs"
}
variable "region" {
  type        = string
  description = "The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
  default     = "East US"
}
variable "cluster_name" {
  type        = string
  description = "The name of the Kubernetes Cluster to create. Changing this forces a new resource to be created."
  default     = "haacs_k8s"
}

variable "vm_size" {
  type        = string
  description = "The size of the Virtual Machine, such as Standard_DS2_v2. Changing this forces a new resource to be created."
  default     = "Standard_DS2_v2"
}

variable "min_node_count" {
  type        = number
  description = "The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000"
  default     = 1
}

variable "max_node_count" {
  type        = number
  description = "The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000."
  default     = 3
}
