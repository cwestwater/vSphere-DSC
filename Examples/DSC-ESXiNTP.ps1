$configurationData = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
            PSDscAllowPlainTextPassword = $true
            PSDscAllowDomainUser = $true
        }
    )
}

Configuration ESXiNTP {
    Import-DscResource -ModuleName VMware.vSphereDSC

    $Credential = Get-Credential

    Node localhost {
            VMHostNtpSettings ESXiNtpSettings {
            Server = 'esxi1.corp.contoso.com'
            Name = 'esxi1.corp.contoso.com'
            Credential = $Credential
            NtpServer = @("uk.pool.ntp.org")
            NtpServicePolicy = "On"
        }
    }
}

ESXiNTP -ConfigurationData $configurationData