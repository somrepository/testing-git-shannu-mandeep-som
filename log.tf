resource "azurerm_log_analytics_workspace" "this" {
name = "law-3tier"
location = var.location
resource_group_name = var.rg_name
sku = "PerGB2018"
}