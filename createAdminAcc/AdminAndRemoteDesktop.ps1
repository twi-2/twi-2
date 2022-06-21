#Requires -RunAsAdministrator

$Password = ConvertTo-SecureString '' -AsPlainText -Force
$Username = ConvertTo-SecureString '' -AsPlainText -Force
$Description = ConvertTo-SecureString '' -AsPlainText -Force

$WinNT = [ADSI]"WinNT://${env:Computername}"
$LocalUsers = $WinNT.Children | where {$_.SchemaClassName -eq 'user'} | % {$_.name[0].ToString()}
if($LocalUsers -contains $Username) {Remove-LocalUser -Name $Username}

New-LocalUser $Username -Password $Password -Desc $Description
Add-LocalGroupMember -G "Administrators" -M $Username

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
