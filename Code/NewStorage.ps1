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
        [string]$UserName,
    [Parameter(Mandatory=$true)]
        [securestring]$PWD,    
    [Parameter(Mandatory=$true)]
        [string]$Prefix
)

begin {    
    $Creds = New-Object system.Management.Automation.PSCredential($UserName,$PWD)    
    Connect-AzAccount -Credential $Creds -Verbose
    Wait-Event -Timeout 5
}

Process{
    $STAccount = Get-AzStorageAccount -ResourceGroupName DeploymentScripts -Name $Prefix"storage"
    New-AzStorageShare -Name testds00 -Context $STAccount.Context 
    Set-AzStorageShareQuota -Context $STAccount.Context -Quota 10 -ShareName testds00

}

End {
    Write-Output -Verbose "Thanks for playing"
}
