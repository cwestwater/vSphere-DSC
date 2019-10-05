$server = 'vcsa1.corp.contoso.com'

$configurationData = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
            PSDscAllowPlainTextPassword = $true
            PSDscAllowDomainUser = $true
        }
    )
}

Configuration DatacenterSetup {
    Import-DscResource -ModuleName VMware.vSphereDSC

    $Credential = Get-Credential

    Node localhost {
        Datacenter vCenterDatacenter {
            Server = $Server
            Credential = $Credential
            Name = 'vGemba'
            Location = ''
            Ensure = 'Absent'
        }
    }
}

DatacenterSetup -ConfigurationData $configurationData