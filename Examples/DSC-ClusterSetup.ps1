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

Configuration ClusterSetup {
    Import-DscResource -ModuleName VMware.vSphereDSC

    $Credential = Get-Credential

    Node localhost {
        DrsCluster vCenterCluster {
            Server = $server
            Credential = $credential
            Ensure = 'Present'
            Location = [string]::Empty
            DatacenterLocation = [string]::Empty
            DatacenterName = 'vGemba'
            Name = 'vGemba Cluster'
            DRSEnabled = $true
            DRSAutomationLevel = 'FullyAutomated'
            DrsMigrationThreshold = 3
            }
    }
}

ClusterSetup -ConfigurationData $configurationData