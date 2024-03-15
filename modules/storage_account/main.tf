locals {
    sa_name = format("%s%s", var.storage_account_prefix, var.environment)

}

resource "azurerm_storage_account" "storage_account" {
  name                     = "${local.sa_name}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  enable_https_traffic_only = true

}