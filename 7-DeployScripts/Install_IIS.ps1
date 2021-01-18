
<#Author       : Dean Cefola	
# Creation Date: 11-30-2017	
# Usage        : Install IIS to Windows Server	
#********************************************************************************	
# Date                         Version      Changes	
#------------------------------------------------------------------------	
# 11/30/2017                     1.0        Intial Version	
#	
#*********************************************************************************	
#	
#>	


Param (
)

Begin {
  install-windowsfeature -name Web-Server -IncludeManagementTools
}

Process {  
  Set-Location -Path c:\inetpub\wwwroot
  Add-Content iisstart.htm "<H1><center>WELCOME to my Web Server $env:COMPUTERNAME, Azure Academy Rocks!</center></H1>"
  Invoke-command -ScriptBlock{iisreset}
}

End {
  $Value = (Get-WindowsFeature -Name Web-Server).installstate
  $Output = Write-Host "IIS is $Value"
  $DeploymentScriptOutputs = @{}
  $DeploymentScriptOutputs['IIS'] = $output
}