variable "vsphere_user" {
  description = "The VSphere API username"
  type        = string
}

variable "vsphere_password" {
  description = "The VSphere API user's password"
  type        = string
}

variable "vsphere_server" {
  description = "The VSphere API address. FQDN or IP"
  type        = string
}

variable "datacenter" {
  description = "The VSphere datacenter"
  type        = string
}

variable "cluster" {
  description = "The VSphere datacenter's cluster"
  type        = string
}

variable "datastore" {
  description = "The VSphere datastore"
  type        = string
}

variable "network" {
  description = "The VSphere network"
  type        = string
}

variable "vm_template" {
  description = "The Virtual Machine template"
  type        = string
}

variable "vm_name" {
  description = "The Virtual Machine name"
  default     = "k8s-node"
  type        = string
}

variable "vm_count" {
  description = "The number of VMs to create"
  default     = 3
  type        = number
}

variable "vm_num_cpus" {
  description = "The number of CPUs to assign to the VM"
  default     = 4
  type        = number
}

variable "vm_num_cores_per_socket" {
  description = "The number of cores per socket to assign to the VM"
  default     = 1
  type        = number
}

variable "vm_memory" {
  description = "The amount of memory to assign to the VM"
  default     = 4096
  type        = number
}

variable "vm_domain" {
  description = "The domain name to assign to the VM"
  type        = string
}

variable "vm_dns_servers" {
  description = "The DNS servers to assign to the VM"
  type        = list(string)
}

variable "vm_ipv4_subnet" {
  description = "The IPv4 subnet to assign to the VM in CIDR notation"
  default     = "192.168.10.0/24"
  type        = string
}
variable "vm_ipv4_ip_start" {
  description = "The IPv4 IP address to start assigning to the VM"
  default     = 10
  type        = number
}

variable "vm_ipv4_gateway" {
  description = "The IPv4 gateway to assign to the VM"
  default     = "192.168.10.1"
  type        = string
}

variable "vm_annotation" {
  description = "The annotation to add to the VM"
  default     = ""
  type        = string
}
