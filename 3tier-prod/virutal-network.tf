resource "azurerm_virtual_network" "vnet" {
name = "vnet-prod"
location = var.location
resource_group_name = var.rg_name
address_space = [var.vnet_cidr]
}


resource "azurerm_subnet" "subnets" {
for_each = {
appgw = "10.0.1.0/24"
frontend = "10.0.2.0/24"
backend = "10.0.3.0/24"
bastion = "10.0.4.0/27"
}


name = each.key
resource_group_name = var.rg_name
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes = [each.value]
}


output "frontend_subnet_id" { value = azurerm_subnet.subnets["frontend"].id }
output "backend_subnet_id" { value = azurerm_subnet.subnets["backend"].id }
output "appgw_subnet_id" { value = azurerm_subnet.subnets["appgw"].id }
output "bastion_subnet_id" { value = azurerm_subnet.subnets["bastion"].id }