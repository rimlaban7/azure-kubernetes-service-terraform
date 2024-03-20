resource "azurerm_public_ip" "public_ip" {
  name                = "PublicIPForLB"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Static"
  sku = "Standard"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_lb" "lb" {
  name                = "LoadBalancer"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_address_pool" {
    name = "LoadBalancerBackendAddressPool"
    loadbalancer_id = azurerm_lb.lb.id   
}

resource "azurerm_lb_nat_pool" "lb_nat_pool" {
    resource_group_name            = azurerm_resource_group.resource_group.name
    loadbalancer_id                = azurerm_lb.lb.id
    name                           = "ssh"
    protocol                       = "Tcp"
    frontend_port_start            = 50000
    frontend_port_end              = 50119
    backend_port                   = 22
    frontend_ip_configuration_name = "PublicIPAddress"
}