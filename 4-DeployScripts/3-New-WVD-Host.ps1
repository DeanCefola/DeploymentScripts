<#Author       : Dean Cefola
# Creation Date: 11-28-2020
# Usage        : Azure Deployment Script (Create Storage Account)

#********************************************************************************
# Date                         Version      Changes
#------------------------------------------------------------------------
# 11/28/2020                     1.0        Intial Version
#
#*********************************************************************************
#
#>

[Cmdletbinding()]
Param (    
    [Parameter(Mandatory=$true)]
        [string]$ResourceGroup,
    [Parameter(Mandatory=$true)]
        [string]$HostPool
)

begin {    
    $Date = (get-date).AddHours(10)
}

Process{    
    $WVDRegToken = New-AzWvdRegistrationInfo `
        -ResourceGroupName $ResourceGroup `
        -HostPoolName $HostPool `
        -ExpirationTime $Date
}

End {
    Write-Output -Verbose $WVDRegToken.Token
}
