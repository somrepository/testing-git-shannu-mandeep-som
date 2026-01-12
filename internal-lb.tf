resource "azurerm_lb" "this" {
name = "internal-lb"
location = var.location
resource_group_name = var.rg_name
sku = "Standard"


frontend_ip_configuration {
name = "internal"
subnet_id = var.subnet_id
}
}


resource "azurerm_lb_backend_address_pool" "pool" {
loadbalancer_id = azurerm_lb.this.id
name = "backend-pool"
}


output "backend_pool_id" { value = azurerm_lb_backend_address_pool.pool.id }