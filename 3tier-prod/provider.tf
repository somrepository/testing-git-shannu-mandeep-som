terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}


provider "azurerm" {
    features {}
    subscription_id = "0dbc7906-293b-41aa-916d-9f62c7c48126"
}