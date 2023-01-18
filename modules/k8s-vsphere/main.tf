terraform {
  required_version = ">= 1.3.0"
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~>2.2.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.25.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.8.0"
    }
  }

  backend "pg" {}
}

provider "digitalocean" {
  token = var.dns_digitalocean_token
}

provider "helm" {
  kubernetes {
    config_path = "artifacts/admin.conf"
  }
}

module "vsphere_vms" {
  source = "../kubespray/contrib/terraform/vsphere"

  vsphere_server   = var.vsphere_server
  vsphere_user     = var.vsphere_user
  vsphere_password = var.vsphere_password

  vsphere_datacenter      = var.vsphere_datacenter
  vsphere_datastore       = var.vsphere_datastore
  vsphere_compute_cluster = var.vsphere_compute_cluster

  machines         = var.machines
  template_name    = var.vm_template_name
  ssh_public_keys  = var.vm_ssh_public_keys
  prefix           = var.vm_name_prefix
  hardware_version = var.vm_hardware_version

  master_cores     = var.vm_master_cores
  master_disk_size = var.vm_master_disk_size
  master_memory    = var.vm_master_memory
  worker_cores     = var.vm_worker_cores
  worker_memory    = var.vm_worker_memory
  worker_disk_size = var.vm_worker_disk_size

  network       = var.vm_network
  gateway       = var.vm_gateway
  dns_primary   = var.vm_dns_primary
  dns_secondary = var.vm_dns_secondary
  domain        = var.vm_domain

  inventory_file = var.inventory_file
}

resource "null_resource" "wait-provisioning" {
  depends_on = [module.vsphere_vms]

  for_each = {
    for name, machine in var.machines :
    name => machine
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.vm_ssh_private_key)
      host        = each.value.ip
    }

    inline = ["echo 'Ready'"]
  }
}

resource "null_resource" "kubernetes" {
  depends_on = [null_resource.wait-provisioning]

  provisioner "local-exec" {
    #command = "docker run --rm -i -v $(pwd)/:/kubespray/inventory/vsphere/ -v ${var.vm_ssh_private_key}:/root/.ssh/ssh_key --network host -e ANSIBLE_HOST_KEY_CHECKING=False joealisson/haacs:kubespray.2.20-terraform ansible-playbook -i /kubespray/inventory/vsphere/${var.inventory_file} /kubespray/cluster.yml -b -v --private-key /root/.ssh/ssh_key"
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${var.inventory_file} ../kubespray/cluster.yml -b -v --private-key ${var.vm_ssh_private_key}"
  }
}

module "dns" {
  source = "../dns"

  providers = {
    digitalocean = digitalocean
  }

  depends_on = [null_resource.kubernetes]

  for_each = {
    for name, machine in var.machines :
    name => machine
    if machine.node_type == "worker"
  }

  digitalocean_token = var.dns_digitalocean_token
  dns_domain         = var.ingress_domain
  dns_ip             = each.value.ip
}

locals {
  masters    = [for name, machine in var.machines : machine if machine.node_type == "master"]
  workers_ip = [for name, machine in var.machines : machine.ip if machine.node_type == "worker"]
}


module "ingress_nginx" {
  source = "../ingress-nginx"

  providers = {
    helm = helm
  }
  depends_on = [null_resource.kubernetes]

  kubeconfig_path                   = "artifacts/admin.conf"
  externalIps                       = format("{%s}", join(",", local.workers_ip))
  default_ssl_certificate           = var.ingress_default_ssl_cert
  default_ssl_certificate_namespace = var.ingress_default_ssl_cert_namespace
  default_ssl_certificate_cert_b64  = var.ingress_default_ssl_cert_b64
  default_ssl_certificate_key_b64   = var.ingress_default_ssl_cert_key_b64
}

module "cert_manager" {
  source = "../cert-manager"

  count = var.enable_certmanage ? 1 : 0

  letsencrypt_email = var.letsencrypt_email

  depends_on = [module.ingress_nginx]

  providers = {
    helm = helm
  }
}

module "argocd" {
  source = "../argocd"

  providers = {
    helm = helm
  }

  depends_on = [module.cert_manager, module.ingress_nginx]

  oidc_key           = var.argocd_oidc_key
  enable_certificate = var.enable_certmanage
  ingress_domain     = var.ingress_domain
}
