terraform {
  required_version = ">= 1.2.6"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.6.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.22.0"
    }
  }
}

module "k8s_infra" {
  source = "../az/infra"
  az_client_id = var.az_client_id
  az_client_secret = var.az_client_secret
  az_tenant_id = var.az_tenant_id
  az_subscription_id = var.az_subscription_id
}

module "ingress_nginx" {
  source = "../ingress-nginx"

  cluster_host = module.k8s_infra.cluster_endpoint
  cluster_ca_certificate_b64 = module.k8s_infra.cluster_certificate
  client_certificate = module.k8s_infra.client_certificate
  client_key = module.k8s_infra.client_key

  loadBalancer_ip = module.k8s_infra.loadbalancer_ip
  provider_loadbalancer_annotation = "service\\.beta\\.kubernetes\\.io/azure-load-balancer-resource-group"
  provider_loadbalancer_annotation_value = module.k8s_infra.loadbalancer_resource_group
}

module "dns" {
  source = "../dns"
  digitalocean_token = var.digitalocean_token
  dns_domain = var.k8s_ingress_domain
  dns_ip = module.k8s_infra.loadbalancer_ip

}

provider "helm" {
  kubernetes {
    host = module.k8s_infra.cluster_endpoint
    client_certificate = base64decode(module.k8s_infra.client_certificate)
    client_key = base64decode(module.k8s_infra.client_key)
    cluster_ca_certificate = base64decode(module.k8s_infra.cluster_certificate)
  }
}


module "cert_manager" {
  source = "../cert-manager"
  letsencrypt_email = var.letsencrypt_email

  depends_on = [module.ingress_nginx]

  providers = {
    helm = helm
  }
}

module "argocd" {
  source = "../argocd"
  argocd_oauth_key = var.argocd_oauth_key
  ingress_domain = var.k8s_ingress_domain

  depends_on = [module.cert_manager]

  providers = {
    helm = helm
  }
}
