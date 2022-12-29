terraform {
  required_version = ">= 1.3.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.8.0"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = var.cluster_host
    token                  = var.cluster_token
    client_certificate     = base64decode(var.client_certificate)
    client_key             = base64decode(var.client_key)
    cluster_ca_certificate = base64decode(
      var.cluster_ca_certificate_b64
    )
  }
}
