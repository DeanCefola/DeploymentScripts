<#Author       : Dean Cefola	
# Creation Date: 11-30-2020	
# Usage        : Azure Deployment Script (Get Azure User Managed ID ObjectID for KeyVault)	
#********************************************************************************	
# Date                         Version      Changes	
#------------------------------------------------------------------------	
# 11/30/2020                     1.0        Intial Version	
#	
#*********************************************************************************	
#	
#>	

[Cmdletbinding()]	
Param(
    [string] [Parameter(Mandatory=$true)] $Prefix    
)
Begin {
    $ErrorActionPreference = 'Stop'
}

Process {
    $ManagedIDObject = (Get-AzUserAssignedIdentity | Where-Object -Property Name -Match $Prefix).PrincipalId
}

End {    
    $Output = $ManagedIDObject
    $DeploymentScriptOutputs = @{}
    $DeploymentScriptOutputs['ManagedIDObject'] = $output
}