param location string
param locationName string
param projectName string
param keyVaultGroupName string

@secure()
param adminLogin string

@secure()
param adminPassword string

@allowed([
  'prod'
  'dev'
])
param environmentType string

var sqlServerName = 'sqlserver-${projectName}-${locationName}-${environmentType}'
var sqlDbName = 'db-${projectName}{-${locationName}-${environmentType}'

resource sqlServer 'Microsoft.Sql/servers@2014-04-01' ={
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
  }
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2014-04-01' = {
  parent: sqlServer
  name: sqlDbName
  location: location
  properties: {
  
  }
  sku: {
    name: 'S2'
    tier: 'Standard'
  }
}
