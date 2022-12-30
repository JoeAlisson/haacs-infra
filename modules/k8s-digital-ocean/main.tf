terraform {
  required_version = ">= 1.3.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.25.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.8.0"
    }
  }

  backend "pg" { }
}

provider "helm" {
  kubernetes {
    host                   = module.kubernetes.cluster_endpoint
    token                  = module.kubernetes.cluster_token
    cluster_ca_certificate = base64decode(module.kubernetes.cluster_certificate)
  }
}

module "kubernetes" {
  source = "../digital-ocean"

  do_token = var.do_token
  cluster_name = var.cluster_name
}

module "dns" {
  source = "../dns"

  digitalocean_token = var.do_token
  dns_domain         = var.k8s_ingress_domain
  dns_ip             = module.kubernetes.load_balancer_ip

}

module "ingress_nginx" {
  source = "../ingress-nginx"

  cluster_token                          = module.kubernetes.cluster_token
  cluster_host                           = module.kubernetes.cluster_endpoint
  cluster_ca_certificate_b64             = module.kubernetes.cluster_certificate
  provider_loadbalancer_annotation       = "kubernetes\\.digitalocean\\.com/load-balancer-id"
  provider_loadbalancer_annotation_value = module.kubernetes.load_balancer_id
}

module "cert_manager" {
  source     = "../cert-manager"
  depends_on = [module.ingress_nginx]
  providers  = {
    helm = helm
  }

  letsencrypt_email = var.letsencrypt_email
}

module "argocd" {
  source = "../argocd"

  oidc_key       = var.argocd_oauth_key
  ingress_domain = var.k8s_ingress_domain
  cert_manager_issuer = var.cert_manager_issuer

  depends_on = [module.cert_manager]

  providers = {
    helm = helm
  }
}
