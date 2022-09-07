terraform {
  required_version = ">= 1.2.6"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.6.0"
    }
  }
}
