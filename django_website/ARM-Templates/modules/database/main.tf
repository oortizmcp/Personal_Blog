  provider "azurerm" {
  features {}

 }


resource "azurerm_postgresql_server" "server" {
  name                = var.server_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = var.sku_name

  storage_mb                   = var.storage_mb
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_login_password
  version                       = var.server_version
  ssl_enforcement_enabled       = var.ssl_enforcement_enabled
  
}

resource "azurerm_postgresql_database" "db" {
  name                = var.db_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  charset             = var.db_charset
  collation           = var.db_collation
}


