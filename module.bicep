param location string
param locationName string
param projectName string
param keyVaultRGName string

@allowed([
  'prod'
  'dev'
])
param environmentType string

@secure()
param adminLogin string

module sql 'main.bicep' = {
  name: 'deploySql'
  params: {
    location:location
    adminLogin: adminLogin
    adminPassword: keyVault.getSecret('sqlpassw') 
    environmentType: environmentType
    locationName: locationName
    projectName: projectName
    keyVaultRGName: keyVaultRGName
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: 'kvsql40'
  scope: resourceGroup(keyVaultRGName)
}
