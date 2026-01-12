resource "azurerm_public_ip" "pip" {
  name                = "appgw-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "this" {
  name                = "appgw-prod"
  location            = var.location
  resource_group_name = var.rg_name

  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
  }

  gateway_ip_configuration {
    name      = "appgw-ip"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "public-frontend"
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  backend_address_pool {
    name = "frontend-backend-pool"
  }

  backend_http_settings {
    name                  = "http-setting"
    port                  = 80
    protocol              = "Http"
    cookie_based_affinity = "Disabled"
    request_timeout       = 30
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "public-frontend"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule-1"
    rule_type                 = "Basic"
    http_listener_name        = "http-listener"
    backend_address_pool_name = "frontend-backend-pool"
    backend_http_settings_name = "http-setting"
    priority                  = 100
  }
}
