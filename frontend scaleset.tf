resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                = "${var.name}-vmss"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard_DS2_v2"
  instances           = 2
  upgrade_mode        = "Manual"

  computer_name_prefix = var.name
  admin_username       = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "nic"
    primary = true

    ip_configuration {
      name      = "internal"
      subnet_id = var.subnet_id
      load_balancer_backend_address_pool_ids = [
        var.backend_pool
      ]
    }
  }
}
