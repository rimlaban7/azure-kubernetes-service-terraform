locals {
    full_virtual_network_name = format("vnet-%s-%s", var.virtual_network_name, var.environment)
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