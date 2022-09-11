provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "udacity-rg" {
  name     = "udacity-rg"
  location = "East US"

  tags = var.common_tags
}

resource "azurerm_virtual_network" "udacity-vnet" {
  name                = "udacity-vnet"
  resource_group_name = azurerm_resource_group.udacity-rg.name
  location            = azurerm_resource_group.udacity-rg.location
  address_space       = ["10.0.0.0/16"]

  tags = var.common_tags
}

resource "azurerm_subnet" "udacity-subnet" {
  name                 = "udacity-subnet"
  resource_group_name  = azurerm_resource_group.udacity-rg.name
  virtual_network_name = azurerm_virtual_network.udacity-vnet.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_network_security_group" "udacity-nsg" {
  name                = "udacity-nsg"
  location            = azurerm_resource_group.udacity-rg.location
  resource_group_name = azurerm_resource_group.udacity-rg.name

  tags = var.common_tags
}

resource "azurerm_network_security_rule" "allow-vm" {
  name                        = "AllowVMInSameSubnet"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.1.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.udacity-rg.name
  network_security_group_name = azurerm_network_security_group.udacity-nsg.name
}

resource "azurerm_network_security_rule" "deny-internet" {
  name                        = "DenyInternetInbound"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.udacity-rg.name
  network_security_group_name = azurerm_network_security_group.udacity-nsg.name
}