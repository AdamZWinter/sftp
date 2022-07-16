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
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "resourceTrackingNameRG" {
  name     = "sftpResourceGroupUSwest3"
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

resource "azurerm_network_profile" "containergroup_profile" {
  name                = "acg-profile"
  resource_group_name = azurerm_resource_group.resourceTrackingNameRG.name
  location            = azurerm_resource_group.resourceTrackingNameRG.location

  container_network_interface {
    name = "acg-nic"

    ip_configuration {
      name      = "aciipconfig"
      subnet_id = azurerm_subnet.resourceTrackingNameSubnetone.id
    }
  }
}

data "azurerm_container_registry" "acr" {
  name                = "ArcticaCR"
  resource_group_name = "crrg"
}

resource "azurerm_container_group" "resourceTrackingNameContainer" {
  name                = "sftptestcontainer"
  resource_group_name = azurerm_resource_group.resourceTrackingNameRG.name
  location            = azurerm_resource_group.resourceTrackingNameRG.location
  ip_address_type     = "Private"
  os_type             = "Linux"
  network_profile_id  = azurerm_network_profile.containergroup_profile.id
  image_registry_credential {
    username = data.azurerm_container_registry.acr.admin_username
    password = data.azurerm_container_registry.acr.admin_password
    server   = data.azurerm_container_registry.acr.login_server
  }

  container {
    name   = "mycontainername001"
    image  = "arcticacr.azurecr.io/sftp01/sftptest:0.01"
    cpu    = "1.0"
    memory = "2.0"

    ports {
      port     = 22
      protocol = "TCP"
    }
    
    //environment_variables = {
      //<add your variables here>
    //}
  }
  
  
  tags = {
    environment = "testing"
  }
}
