terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.37.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.8.0"
    }
  }

  backend "pg" {}

}

provider "helm" {
  kubernetes {
    host                   = module.kubernetes.cluster_endpoint
    client_certificate     = base64decode(module.kubernetes.client_certificate)
    client_key             = base64decode(module.kubernetes.client_key)
    cluster_ca_certificate = base64decode(module.kubernetes.cluster_certificate)
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}

module "kubernetes" {
  source = "../azure"

  client_id     = var.azure_client_id
  client_secret = var.azure_client_secret
  tenant        = var.azure_tenant
  subscription  = var.azure_subscription
  cluster_name  = var.cluster_name
}

module "dns" {
  source = "../dns"

  providers = {
    digitalocean = digitalocean
  }

  digitalocean_token = var.digitalocean_token
  dns_domain         = var.k8s_ingress_domain
  dns_ip             = module.kubernetes.loadbalancer_ip
}

module "ingress_nginx" {
  source = "../ingress-nginx"

  providers = {
    helm = helm
  }

  loadBalancer_ip                        = module.kubernetes.loadbalancer_ip
  provider_loadbalancer_annotation       = "service\\.beta\\.kubernetes\\.io/azure-load-balancer-resource-group"
  provider_loadbalancer_annotation_value = module.kubernetes.loadbalancer_resource_group
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

  oidc_key            = var.argocd_oauth_key
  ingress_domain      = var.k8s_ingress_domain
  cert_manager_issuer = var.cert_manager_issuer

  depends_on = [module.cert_manager]

  providers = {
    helm = helm
  }
}
