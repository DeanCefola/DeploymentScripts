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
}	
Process{	
    $STAccount = Get-AzStorageAccount `
        -ResourceGroupName $RGName `
        -Name $STName
    $TestShare = Get-AzStorageShare `
        -Name $ShareName `
        -Context $STAccount.Context `
        -ErrorAction SilentlyContinue
    if ($TestShare -eq $null){
        write-host "Creating Share"
        New-AzStorageShare `
            -Name $ShareName `
            -Context $STAccount.Context 	
        Set-AzStorageShareQuota `
            -Context $STAccount.Context `
            -Quota 10 `
            -ShareName $ShareName	
    }
    else {
        Write-Host "Share already exists, checking size"
        if($Testshare.Quota -eq 10) {
            Write-Host "Share is already the correct size"         
        }
        else {
            Write-Host "Setting Share Quota"
            Set-AzStorageShareQuota `
                -Context $STAccount.Context `
                -Quota 10 `
                -ShareName $ShareName
        }
    }
}	
End {
    $Output = "Share $ShareName was created in storage account $STName in Resource Group $RGName"
    $DeploymentScriptOutputs = @{}
    $DeploymentScriptOutputs['text'] = $output
}	
