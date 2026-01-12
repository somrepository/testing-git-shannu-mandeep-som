resource "azurerm_storage_account" "this" {
name = "st3tierprod"
resource_group_name = var.rg_name
location = var.location
account_tier = "Standard"
account_replication_type = "LRS"
}