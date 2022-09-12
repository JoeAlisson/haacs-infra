terraform {
  required_version = ">= 1.2.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.22.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id       = var.az_client_id
  client_secret   = var.az_client_secret
  tenant_id       = var.az_tenant_id
  subscription_id = var.az_subscription_id
}
