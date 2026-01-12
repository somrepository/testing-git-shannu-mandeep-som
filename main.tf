module "network" {
source = "./modules/network"
rg_name = azurerm_resource_group.rg.name
location = var.location
vnet_cidr = var.vnet_cidr
}


module "log" {
source = "./modules/log"
rg_name = azurerm_resource_group.rg.name
location = var.location
}


module "keyvault" {
source = "./modules/keyvault"
rg_name = azurerm_resource_group.rg.name
location = var.location
}


module "storage" {
source = "./modules/storage"
rg_name = azurerm_resource_group.rg.name
location = var.location
}


module "bastion" {
source = "./modules/bastion"
rg_name = azurerm_resource_group.rg.name
location = var.location
subnet_id = module.network.bastion_subnet_id
}


module "appgw" {
source = "./modules/appgw"
rg_name = azurerm_resource_group.rg.name
location = var.location
subnet_id = module.network.appgw_subnet_id
}


module "frontend" {
source = "./modules/vmss"
name = "frontend"
rg_name = azurerm_resource_group.rg.name
location = var.location
subnet_id = module.network.frontend_subnet_id
backend_pool = module.appgw.backend_pool_id
}


module "backend_lb" {
source = "./modules/internal-lb"
rg_name = azurerm_resource_group.rg.name
location = var.location
subnet_id = module.network.backend_subnet_id
}


module "backend" {
source = "./modules/vmss"
name = "backend"
rg_name = azurerm_resource_group.rg.name
location = var.location
subnet_id = module.network.backend_subnet_id
backend_pool = module.backend_lb.backend_pool_id
}