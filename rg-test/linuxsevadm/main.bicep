param connections_azurevm_name string = 'azurevm'
param connections_azurevm_1_name string = 'azurevm-1'
param virtualMachines_linuxVM1_name string = 'linuxVM1'
param bastionHosts_Linux_Bastion_name string = 'Linux_Bastion'
param virtualNetworks_vnet_westus_name string = 'vnet-westus'
param networkInterfaces_linuxvm1646_name string = 'linuxvm1646'
param networkSecurityGroups_linuxVM1_nsg_name string = 'linuxVM1-nsg'
param schedules_shutdown_computevm_linuxvm1_name string = 'shutdown-computevm-linuxvm1'

resource networkSecurityGroups_linuxVM1_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: networkSecurityGroups_linuxVM1_nsg_name
  location: 'westus'
  properties: {
    securityRules: []
  }
}

resource virtualNetworks_vnet_westus_name_resource 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: virtualNetworks_vnet_westus_name
  location: 'westus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '172.16.0.0/16'
      ]
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'snet-westus-1'
        id: virtualNetworks_vnet_westus_name_snet_westus_1.id
        properties: {
          addressPrefixes: [
            '172.16.0.0/24'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource connections_azurevm_name_resource 'Microsoft.Web/connections@2016-06-01' = {
  name: connections_azurevm_name
  location: 'westus'
  kind: 'V1'
  properties: {
    displayName: 'live.com#sandeep.s.ch@hotmail.com'
    statuses: [
      {
        status: 'Connected'
      }
    ]
    customParameterValues: {}
    nonSecretParameterValues: {
      'token:grantType': 'code'
    }
    createdTime: '2025-11-03T14:14:33.3367394Z'
    changedTime: '2026-01-14T08:23:42.1267095Z'
    api: {
      name: connections_azurevm_name
      displayName: 'Azure VM'
      description: 'Azure VM connector allows you to manage virtual machines.'
      iconUri: 'https://conn-afd-prod-endpoint-bmc9bqahasf3grgk.b01.azurefd.net/v1.0.1780/1.0.1780.4444/${connections_azurevm_name}/icon.png'
      id: '/subscriptions/f05b75f0-4b3d-4759-bbfc-0b29feb82407/providers/Microsoft.Web/locations/westus/managedApis/${connections_azurevm_name}'
      type: 'Microsoft.Web/locations/managedApis'
    }
    testLinks: []
  }
}

resource connections_azurevm_1_name_resource 'Microsoft.Web/connections@2016-06-01' = {
  name: connections_azurevm_1_name
  location: 'westus'
  kind: 'V1'
  properties: {
    displayName: 'new_conn_220c3'
    statuses: [
      {
        status: 'Ready'
      }
    ]
    customParameterValues: {}
    createdTime: '2025-11-03T14:39:22.3018164Z'
    changedTime: '2025-11-03T14:39:22.3018164Z'
    api: {
      name: 'azurevm'
      displayName: 'Azure VM'
      description: 'Azure VM connector allows you to manage virtual machines.'
      iconUri: 'https://conn-afd-prod-endpoint-bmc9bqahasf3grgk.b01.azurefd.net/v1.0.1780/1.0.1780.4444/azurevm/icon.png'
      id: '/subscriptions/f05b75f0-4b3d-4759-bbfc-0b29feb82407/providers/Microsoft.Web/locations/westus/managedApis/azurevm'
      type: 'Microsoft.Web/locations/managedApis'
    }
    testLinks: []
  }
}

resource virtualMachines_linuxVM1_name_resource 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: virtualMachines_linuxVM1_name
  location: 'westus'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_linuxVM1_name}_OsDisk_1_98ec592a08ed46c0ab2d055827bde544'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_linuxVM1_name}_OsDisk_1_98ec592a08ed46c0ab2d055827bde544'
          )
        }
        deleteOption: 'Delete'
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_linuxVM1_name
      adminUsername: 'shyam'
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_linuxvm1646_name_resource.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
  }
}

resource schedules_shutdown_computevm_linuxvm1_name_resource 'microsoft.devtestlab/schedules@2018-09-15' = {
  name: schedules_shutdown_computevm_linuxvm1_name
  location: 'westus'
  properties: {
    status: 'Enabled'
    taskType: 'ComputeVmShutdownTask'
    dailyRecurrence: {
      time: '2200'
    }
    timeZoneId: 'India Standard Time'
    notificationSettings: {
      status: 'Enabled'
      timeInMinutes: 30
      emailRecipient: 'sandeep.s.ch@hotmail.com'
      notificationLocale: 'en'
    }
    targetResourceId: virtualMachines_linuxVM1_name_resource.id
  }
}

resource bastionHosts_Linux_Bastion_name_resource 'Microsoft.Network/bastionHosts@2024-07-01' = {
  name: bastionHosts_Linux_Bastion_name
  location: 'westus'
  sku: {
    name: 'Developer'
  }
  properties: {
    dnsName: 'omnibrain.westus.bastionglobal.azure.com'
    scaleUnits: 2
    virtualNetwork: {
      id: virtualNetworks_vnet_westus_name_resource.id
    }
    ipConfigurations: []
  }
}

resource virtualNetworks_vnet_westus_name_snet_westus_1 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: '${virtualNetworks_vnet_westus_name}/snet-westus-1'
  properties: {
    addressPrefixes: [
      '172.16.0.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnet_westus_name_resource
  ]
}

resource networkInterfaces_linuxvm1646_name_resource 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: networkInterfaces_linuxvm1646_name
  location: 'westus'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_linuxvm1646_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '172.16.0.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_vnet_westus_name_snet_westus_1.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_linuxVM1_nsg_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}
