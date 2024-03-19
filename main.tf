locals {
    full_resource_group_name = format("rg-%s-%s", var.resource_group_name, var.environment)
    full_storage_account_name = format("st%s%s", var.storage_account_name, var.environment)
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