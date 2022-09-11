resource "azurerm_network_interface" "udacity-nic" {
  name                = "udacity-nic"
  location            = azurerm_resource_group.udacity-rg.location
  resource_group_name = azurerm_resource_group.udacity-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.udacity-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "udacity-public-ip" {
  name                = "udacity-public-ip"
  resource_group_name = azurerm_resource_group.udacity-rg.name
  location            = azurerm_resource_group.udacity-rg.location
  allocation_method   = "Dynamic"

  tags = var.common_tags
}

resource "azurerm_lb" "udacity-lb" {
  name                = "udacity-lb"
  location            = azurerm_resource_group.udacity-rg.location
  resource_group_name = azurerm_resource_group.udacity-rg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.udacity-public-ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "udacity-lb-BackEndAddressPool" {
  loadbalancer_id = azurerm_lb.udacity-lb.id
  name            = "udacity-backend-address-pool"
}
