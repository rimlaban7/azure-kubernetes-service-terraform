locals {
  full_resource_group_name = format("rg-%s-%s", var.resource_group_name, var.environment)
}

resource "random_pet" "azurerm_kubernetes_cluster_name" {
  prefix = "cluster"
}

resource "random_pet" "azurerm_kubernetes_cluster_dns_prefix" {
  prefix = "dns"
}

resource "azurerm_resource_group" "resource_group" {
  name     = local.full_resource_group_name
  location = var.location

  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_account" "storage_account" {
  name                             = "stakstfstateprod" 
  resource_group_name              = azurerm_resource_group.resource_group.name
  location                         = azurerm_resource_group.resource_group.location
  account_tier                     = var.account_tier
  account_replication_type         = var.account_replication_type
  enable_https_traffic_only        = true
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false
  min_tls_version                  = "TLS1_2"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  location            = azurerm_resource_group.resource_group.location
  name                = random_pet.azurerm_kubernetes_cluster_name.id
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = random_pet.azurerm_kubernetes_cluster_dns_prefix.id

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.node_count
  }
  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}
