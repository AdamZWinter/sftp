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

resource "azurerm_resource_group" "resourceTrackingNameRG" {
  name     = "sftpResourceGroup"
  location = "westus3"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "resourceTrackingNameVnet" {
  name                = "sftpvnet"
  resource_group_name = azurerm_resource_group.resourceTrackingNameRG.name
  location            = azurerm_resource_group.resourceTrackingNameRG.location
  address_space       = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "resourceTrackingNameSubnetone" {
  name                 = "sftptestsubnetone"
  resource_group_name  = azurerm_resource_group.resourceTrackingNameRG.name
  virtual_network_name = azurerm_virtual_network.resourceTrackingNameVnet.name
  address_prefixes     = ["10.10.1.0/24"]

  delegation {
    name = "sftponesubnetdelegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
    }
  }
}

resource "azurerm_subnet" "resourceTrackingNameSubnetzero" {
  name                 = "sftptestsubnetzero"
  resource_group_name  = azurerm_resource_group.resourceTrackingNameRG.name
  virtual_network_name = azurerm_virtual_network.resourceTrackingNameVnet.name
  address_prefixes     = ["10.10.0.0/24"]
}

resource "azurerm_public_ip" "resourceTrackingNamePublicIPone" {
  name                = "sftptestpublicip"
  resource_group_name = azurerm_resource_group.resourceTrackingNameRG.name
  location            = azurerm_resource_group.resourceTrackingNameRG.location
  allocation_method   = "Static"

  tags = {
    environment = "test"
  }
}

resource "azurerm_lb" "resourceTrackingNameTestLB" {
  name                = "sftptestloadbalancer"
  resource_group_name = azurerm_resource_group.resourceTrackingNameRG.name
  location            = azurerm_resource_group.resourceTrackingNameRG.location

  frontend_ip_configuration {
    name                 = "sftptestFEIPConfig4LB"
    public_ip_address_id = azurerm_public_ip.resourceTrackingNamePublicIPone.id
  } 
}

