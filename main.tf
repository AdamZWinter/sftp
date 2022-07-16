# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
}

provider "azurerm" {
  client_id       = var.clientid
  client_secret   = var.clientsecret
  subscription_id = var.subscriptionid
  tenant_id       = var.tenantid
  features {}
}

resource "azurerm_resource_group" "mylabelforrg" {
  name     = "myTFResourceGroup"
  location = "westus2"
  
  
}
