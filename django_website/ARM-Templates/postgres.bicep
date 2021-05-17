
param RESOURCEGROUPNAME string
param LOCATION string
param POSTGRES_SKU string
param POSTGRES_SERVER_NAME string
param POSTGRES_DB_NAME string
param POSTGRES_ADMIN string
param POSTGRES_PASSWORD string


resource postgres 'Microsoft.DBForPostgreSQL/servers@2017-12-01' = {
  name: POSTGRES_SERVER_NAME
  location: LOCATION
  sku: {
    name: POSTGRES_SKU
    tier: 'Basic'
    capacity: 2
    size: '51200'
    family: 'Gen4'
  }
  properties: {
    createMode: 'Default'
    version: '10'
    administratorLogin: POSTGRES_ADMIN
    administratorLoginPassword: POSTGRES_PASSWORD
  }
}

