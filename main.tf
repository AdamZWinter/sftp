# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

variable "clientid" {
  description = "Azure Client ID"
  type        = string
  sensitive   = true
}

variable "clientsecret" {
  description = "Azure Client Service Principal Secret"
  type        = string
  sensitive   = true
}

variable "subscriptionid" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}

variable "tenantid" {
  description = "Azure Tenant ID"
  type        = string
  sensitive   = true
}

provider "azurerm" {
  features {}
  
  client_id       = var.clientid
  client_secret   = var.clientsecret
  subscription_id = var.subscriptionid
  tenant_id       = var.tenantid
}

resource "azurerm_resource_group" "mylabelforrg" {
  name     = "myTFResourceGroup"
  location = "westus2"
  
  
}
