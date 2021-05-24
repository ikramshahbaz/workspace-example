resource "azurerm_resource_group" "resourcegroup" {
  name     = var.rgname
  location = var.location
  tags = var.tags

  provisioner "local-exec" {
    command = "echo '${self.id}' "
  }
}

resource "azurerm_virtual_network" "main_network" {
  name                           = var.main_network_name
  resource_group_name            = var.rgname
  location                       = var.location
  address_space                  = var.main_address_space
}

resource "azurerm_subnet" "internal_subnet" {
#  count                         = length(var.internal_subnet_address_space)
  count                  = var.internal_subnet_address_count
  name                   = "${var.subnet_name}-${count.index}"
  resource_group_name    = var.rgname
  virtual_network_name   = azurerm_virtual_network.main_network.name
  address_prefixes       = [element(var.internal_subnet_address_space, count.index)]
}
