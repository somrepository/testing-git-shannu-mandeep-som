resource "azurerm_public_ip" "pip" {
name = "bastion-pip"
location = var.location
resource_group_name = var.rg_name
allocation_method = "Static"
sku = "Standard"
}


resource "azurerm_bastion_host" "this" {
name = "bastion-prod"
location = var.location
resource_group_name = var.rg_name


ip_configuration {
name = "config"
subnet_id = var.subnet_id
public_ip_address_id = azurerm_public_ip.pip.id
}
}