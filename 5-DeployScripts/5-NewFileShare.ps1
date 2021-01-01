<#Author       : Dean Cefola	
# Creation Date: 11-28-2020	
# Usage        : Azure Deployment Script (Create Azure Files Share 10G)	
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
        [string]$Prefix,
        [Parameter(Mandatory=$true)]	
        [string]$RGName
)	
Begin {    	
    $STName = $Prefix+"storage"
    $ShareName = 'share05'
    $ErrorActionPreference = 'Stop'
}	
Process{	
    $STAccount = Get-AzStorageAccount `
        -ResourceGroupName $RGName `
        -Name $STName	
    New-AzStorageShare `
        -Name $ShareName `
        -Context $STAccount.Context 	
    Set-AzStorageShareQuota `
        -Context $STAccount.Context `
        -Quota 10 `
        -ShareName $ShareName	
}	
End {
    $Output = "Share $ShareName was created in storage account $STName in Resource Group $RGName"
    $DeploymentScriptOutputs = @{}
    $DeploymentScriptOutputs['text'] = $output
}	
