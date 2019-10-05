$server = 'vcsa1.corp.contoso.com'

$configurationData = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
            PSDscAllowPlainTextPassword = $true
            PSDscAllowDomainUser = $true #needed if connecting to vCenter
        }
    )
}

Configuration vCSASetup {
    Import-DscResource -ModuleName VMware.vSphereDSC

    $Credential = Get-Credential

    Node localhost {
        DrsCluster vCenterCluster {
            DependsOn = '[Datacenter]vCenterDatacenter'
            Server = $server
            Credential = $credential
            Ensure = 'Present'
            Location = ''
            DatacenterLocation = ''
            DatacenterName = 'vGemba'
            Name = 'vGemba Cluster'
            DRSEnabled = $true
            DRSAutomationLevel = 'PartiallyAutomated'
            DrsMigrationThreshold = '5'
        }

        Datacenter vCenterDatacenter {
            Server = $Server
            Credential = $Credential
            Name = 'vGemba'
            Location = ''
            Ensure = 'Present'
        }
    }
}

vCSASetup -ConfigurationData $configurationData