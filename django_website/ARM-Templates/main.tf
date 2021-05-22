terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.56.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraformstate"
    storage_account_name = "oovterrastatestor1882"
    container_name       = "terraformdemo"
    key                  = "terraform.database.tfstate"
  }
}

provider "azurerm" {
  features {}

}

data "azurerm_key_vault_secret" "postgres_admin_password" {
  name         = "postgres-password"
  key_vault_id = "/subscriptions/953f4cd5-5c36-40a5-be4e-cca2b3216f2c/resourceGroups/azlab/providers/Microsoft.KeyVault/vaults/tfkeyvault"


}


resource "azurerm_resource_group" "blogrg" {
  name     = "blog-rg"
  location = "Central US"
}

module "database" {
  source = "./modules/database"

  resource_group_name          = azurerm_resource_group.blogrg.name
  location                     = azurerm_resource_group.blogrg.location
  server_name                  = "oovpostgresql052121"
  sku_name                     = "B_Gen5_1"
  storage_mb                   = 5120
  administrator_login          = "cloudadmin"
  administrator_login_password = data.azurerm_key_vault_secret.postgres_admin_password.value
  server_version               = "9.5"
  ssl_enforcement_enabled      = true
  db_name                      = "blogdb"
  db_charset                   = "UTF8"
  db_collation                 = "English_United States.1252"

}

module "webapp" {
  source = "./modules/webapp"

  asp_plan            = "oovblog-asp"
  location            = azurerm_resource_group.blogrg.location
  resource_group_name = azurerm_resource_group.blogrg.name
  asptier             = "Basic"
  aspsku              = "B1"
  app_name            = "oovblog"
}