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
        [string]$Prefix	
)	
Begin {    	
    $ShareName = 'share05'
}	
Process{	
    $STAccount = Get-AzStorageAccount -ResourceGroupName DeploymentScripts -Name $Prefix	
    New-AzStorageShare -Name $ShareName -Context $STAccount.Context 	
    Set-AzStorageShareQuota -Context $STAccount.Context -Quota 10 -ShareName $ShareName	
}	
End {	
    $ShareName | Out-String
}	
