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
    siteConfig: {
      nodeVersion: '18.5.0'
      appSettings: [
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: '18.5.0'
        }
        {
          name: 'SQL_SERVER_NAME'
          value: 'italian-project-dev-server-1.database.windows.net'
        }
        {
          name: 'SQL_SERVER_DB_NAME'
          value: 'italian-project-dev-db-1'
        }
        {
          name: 'SQL_SERVER_USERNAME'
          value: 'jamieorr'
        }
        {
          name: 'SQL_SERVER_PASSWORD'
          value: 'Bugattiv4?!'
        }
      ]
    }
  }
}

resource frontend 'Microsoft.Web/sites@2022-09-01' = {
  name: frontendAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      nodeVersion: '18.5.0'
      appSettings: [
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: '18.5.0'
        }
      ]
    }
  }
}
