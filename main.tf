# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
}

variable "SP_CLIENT_ID" {
  description = "Azure Client ID"
  type        = string
  sensitive   = true
}

variable "SP_CLIENT_SECRET" {
  description = "Azure Client Service Principal Secret"
  type        = string
  sensitive   = true
}

variable "SUBSCRIPTION_ID" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}

variable "SP_TENANT_ID" {
  description = "Azure Tenant ID"
  type        = string
  sensitive   = true
}

provider "azurerm" {
  subscription_id = var.SUBSCRIPTION_ID
  client_id       = var.SP_CLIENT_ID
  client_secret   = var.SP_CLIENT_SECRET
  tenant_id       = var.SP_TENANT_ID
  features {}
}

resource "azurerm_resource_group" "mylabelforrg" {
  name     = "myTFResourceGroup"
  location = "westus2"
  
  
}
