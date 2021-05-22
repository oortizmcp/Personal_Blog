provider "azurerm" {
    features {}
  
}

resource "azurerm_app_service_plan" "asp" {
  name                = var.asp_plan
  location            = var.location
  resource_group_name = var.resource_group_name
  kind = "Linux"

  sku {
    tier = var.asptier
    size = var.aspsku
  }
}

resource "azurerm_app_service" "blog" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    dotnet_framework_version = "v4.0"
  }

}