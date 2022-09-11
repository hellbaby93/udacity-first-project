resource "azurerm_availability_set" "udacity-as" {
  name                = "udacity-as"
  location            = azurerm_resource_group.udacity-rg.location
  resource_group_name = azurerm_resource_group.udacity-rg.name

  tags = var.common_tags
}

resource "azurerm_linux_virtual_machine" "udacity-machine" {
  count = var.number_of_vm

  name                            = format("udacity-machine-%d", count.index)
  resource_group_name             = azurerm_resource_group.udacity-rg.name
  location                        = azurerm_resource_group.udacity-rg.location
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  admin_password                  = "Def@ultp@ssword"
  availability_set_id             = azurerm_availability_set.udacity-as.id
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.udacity-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = var.image_id

  tags = var.common_tags
}
