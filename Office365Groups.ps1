$username = "adminpts@bkmob.onmicrosoft.com"
$mycred = get-Credential -UserName $username -Message "Log on"
$ExchSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $mycred -Authentication Basic -AllowRedirection
Import-PSSession $ExchSession
$o365group = Get-UnifiedGroup | Out-GridView -Title "Select group" -OutputMode Single
$o365group | fl
$o365group.Identity

Set-UnifiedGroup -Identity $o365group.Identity -EmailAddresses @{Add = 'smtp:bodobylab@bodo.kommune.no'}
Get-UnifiedGroup -Identity $o365group.Identity | select Alias, EmailAddresses