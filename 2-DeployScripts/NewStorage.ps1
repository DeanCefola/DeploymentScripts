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
        [string]$Prefix
)
begin {    
    
}
Process{
    $STAccount = Get-AzStorageAccount -ResourceGroupName DeploymentScripts -Name $Prefix
    New-AzStorageShare -Name testds00 -Context $STAccount.Context 
    Set-AzStorageShareQuota -Context $STAccount.Context -Quota 10 -ShareName testds00
    #$a = Get-AzStorageShare -Name testds00
    
}
End {
    #Write-Output $DSOutput
}

