param environmentId string = 'p1'
param productId string = 'lgw'
param location string = resourceGroup().location
param frontendAppName string = 'apsvc-${environmentId}-${productId}-frontend'
param backendAppName string = 'apsvc-${environmentId}-${productId}-backend'
param appServicePlanName string = 'apspl-${environmentId}-${productId}'

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
}

resource backend 'Microsoft.Web/sites@2022-09-01' = {
  name: backendAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource frontend 'Microsoft.Web/sites@2022-09-01' = {
  name: frontendAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}
