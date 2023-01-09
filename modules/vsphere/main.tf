terraform {
  required_version = ">= 1.3.0"
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~>2.2.0"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

resource "vsphere_virtual_machine" "vm" {
  count                            = var.vm_count
  name                             = "${var.vm_name}${count.index}"
  resource_pool_id                 = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id                     = data.vsphere_datastore.datastore.id
  guest_id                         = data.vsphere_virtual_machine.template.guest_id
  scsi_type                        = data.vsphere_virtual_machine.template.scsi_type
  enable_disk_uuid                 = true
  boot_retry_enabled               = true
  run_tools_scripts_after_power_on = true
  tools_upgrade_policy             = "upgradeAtPowerCycle"
  annotation                       = var.vm_annotation

  num_cpus               = var.vm_num_cpus
  num_cores_per_socket   = var.vm_num_cores_per_socket
  cpu_hot_remove_enabled = true
  cpu_hot_add_enabled    = true

  memory                 = var.vm_memory
  memory_hot_add_enabled = true

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "${var.vm_name}${count.index}"
        domain    = var.vm_domain
      }
      network_interface {
        dns_domain      = var.vm_domain
        dns_server_list = var.vm_dns_servers
        ipv4_address    = cidrhost(var.vm_ipv4_subnet, var.vm_ipv4_ip_start + count.index)
        ipv4_netmask    = tonumber(split("/", var.vm_ipv4_subnet)[1])
      }

      ipv4_gateway = var.vm_ipv4_gateway

      dns_server_list = var.vm_dns_servers
      dns_suffix_list = [var.vm_domain]

    }
  }

}
