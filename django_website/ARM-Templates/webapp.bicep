

param appServicePlanName string = 'oovblog-asp'
param location string = resourceGroup().location
param webappSku string = 'B1'
param family string = 'B'
param tier string = 'Basic'

param sitename string = 'oovblog'
param linuxFxVersion string = 'Docker|appsvcorg/django-python:0.1'



resource appPlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: webappSku
    tier: tier
    size: webappSku
    family: family
    capacity: 1
  }
  kind: 'linux'
}

resource site 'Microsoft.Web/sites@2020-06-01' = {
  name: sitename
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appPlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
    }
  }
}
