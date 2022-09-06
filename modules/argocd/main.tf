terraform {
  required_version = ">= 1.2.6"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.6.0"
    }
  }
}

provider "helm" {
  kubernetes {
    host  = var.cluster_host
    token = var.cluster_token
    cluster_ca_certificate = base64decode(
      var.cluster_ca_certificate_b64
    )
  }
}
