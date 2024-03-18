resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  enable_https_traffic_only = true
  allow_nested_items_to_be_public = false
  cross_tenant_replication_enabled = false
  min_tls_version = "TLS1_2"

  tags = {
    source = "terraform"
  }
}