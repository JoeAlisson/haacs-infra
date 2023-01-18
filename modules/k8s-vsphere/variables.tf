variable "vsphere_server" {
  description = "The VSphere API address. FQDN or IP"
  type        = string
}

variable "vsphere_user" {
  description = "The VSphere API username"
  type        = string
}

variable "vsphere_password" {
  description = "The VSphere API user's password"
  type        = string
}

variable "vsphere_datacenter" {
  description = "The VSphere datacenter"
  type        = string
}

variable "vsphere_compute_cluster" {
  description = "The VSphere datacenter's cluster"
  type        = string
}

variable "vsphere_datastore" {
  description = "The VSphere datastore"
  type        = string
}

variable "vm_network" {
  description = "The VSphere network"
  type        = string
}

variable "vm_template_name" {
  description = "The Virtual Machine template"
  type        = string
}

variable "vm_gateway" {
  description = "The IPv4 gateway to assign to the VM"
  default     = "192.168.10.1"
  type        = string
}

variable "machines" {
  description = "Cluster machines"
  type        = map(object({
    node_type = string
    ip        = string
    netmask   = string
  }))
}

variable "vm_ssh_public_keys" {
  description = "List of public SSH keys which are injected into the VMs."
  type        = list(string)
}

variable "vm_name_prefix" {
  description = "The Virtual Machine name prefix"
  default     = "k8s-node"
  type        = string
}

variable "vm_dns_primary" {
  description = "The DNS servers to assign to the VM"
  type        = string
  default     = "8.8.8.8"
}

variable "vm_dns_secondary" {
  description = "The DNS servers to assign to the VM"
  type        = string
  default     = "8.8.4.4"
}

variable "vm_domain" {
  description = "The DNS domain to assign to the VM"
  type        = string
  default     = "local"
}

variable "vm_hardware_version" {
  description = "The Virtual Machine hardware version"
  type        = string
  default     = "19"
}

variable "vm_master_cores" {
  description = "The Virtual Machine master cores"
  type        = number
  default     = 4
}

variable "vm_master_disk_size" {
  description = "The Virtual Machine master disk size"
  type        = number
  default     = 30
}

variable "vm_master_memory" {
  description = "The Virtual Machine master memory"
  type        = number
  default     = 4096
}

variable "vm_worker_cores" {
  description = "The Virtual Machine worker cores"
  type        = number
  default     = 4
}

variable "vm_worker_memory" {
  description = "The Virtual Machine worker memory"
  type        = number
  default     = 4096
}

variable "vm_worker_disk_size" {
  description = "The Virtual Machine worker disk size"
  type        = number
  default     = 50
}

variable "vm_ssh_private_key" {
  description = "The SSH private key path to use to connect to the VM"
  type        = string
}

variable "inventory_file" {
  description = "Path to the inventory file"
  type        = string
  default     = "inventory.ini"
}

### DNS variables
variable "dns_digitalocean_token" {
  description = "The DigitalOcean API token"
  type        = string
}

variable "ingress_domain" {
  description = "The ingress domain"
  type        = string
}

variable "ingress_default_ssl_cert" {
  description = "The ingress default SSL certificate"
  type        = string
  default     = "tls-cert"
}

variable "ingress_default_ssl_cert_namespace" {
  description = "The ingress default SSL certificate namespace"
  type        = string
  default     = "default"
}
variable "ingress_default_ssl_cert_b64" {
  description = "The ingress default SSL certificate base64 encoded"
  type        = string
  default     = ""
  sensitive   = true
}
variable "ingress_default_ssl_cert_key_b64" {
  description = "The ingress default SSL certificate key base64 encoded"
  type        = string
  default     = ""
  sensitive   = true
}

variable "argocd_oidc_key" {
  description = "The ArgoCD OIDC key"
  type        = string
  default     = ""
}

variable "enable_certmanage" {
  description = "Enable cert-manager"
  type        = bool
  default     = false
}

variable "letsencrypt_email" {
  description = "The Let's Encrypt email"
  type        = string
  default     = ""
}
