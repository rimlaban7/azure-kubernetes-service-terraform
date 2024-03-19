terraform {

  required_version = ">=1.7.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.92.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

locals {
    full_resource_group_name = format("rg-%s-%s", var.resource_group_name, var.environment)
    full_storage_account_name = format("st%s%s", var.storage_account_name, var.environment)
    full_virtual_network_name = format("vnet-%s-%s", var.virtual_network_name, var.environment)
}

resource "azurerm_resource_group" "resource_group" {
  name     = local.full_resource_group_name
  location = var.location

  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_account" "storage_account" {
  name                     = local.full_storage_account_name
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  enable_https_traffic_only = true
  allow_nested_items_to_be_public = false
  cross_tenant_replication_enabled = false
  min_tls_version = "TLS1_2"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = local.full_virtual_network_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = ["10.0.0.0/20"]

  subnet = {
    name = "subnet_1"
    address_prefix = "10.0.1.0/24"
  }

  tags = {
    environment = var.environment
  }
}
