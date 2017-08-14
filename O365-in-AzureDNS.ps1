# This script automatically configures Azure DNS for O365
# Written by Per-Torben Sørensen (per-torben.sorensen@advania.no)
# 
# Version: 1.0
#*********************************************************************************************
#
# Input values below
$azureadmin = "me@example.onmicrosoft.com" # admin user in azure portal with DNS rights
$ttl = "600" # TTL for all records (in seconds)
$zonename = "azure.sorensen.ws" 
$rgname = "testazuredns" # Use Get-AzureRmDnsZone after login to find this
$proofvalue = "MS=ms15668136" # Proof of ownership from the Office 365 portal
#
#*********************************************************************************************
#
# Variables below
#
$cred = Get-Credential -Message "Log on" -UserName $azureadmin
$runscript = $false # Failsafe for accidental running
#*********************************************************************************************
if ($runscript -eq $true)
{
# Log on Azure RM and set DNS variable
Login-AzureRmAccount -Credential $cred
$dnszone = Get-AzureRmDnsZone -Name $zonename -ResourceGroupName $rgname
#
# Creating first TXT record
New-AzureRmDnsRecordSet -Zone $dnszone -Name "@" -RecordType TXT -Ttl $ttl -DnsRecords (New-AzureRmDnsRecordConfig -Value "$($proofvalue)")
#
# CNAME records
New-AzureRmDnsRecordSet -Zone $dnszone -Name "autodiscover" -RecordType CNAME -Ttl $ttl -DnsRecords (New-AzureRmDnsRecordConfig -cname "autodiscover.outlook.com")
New-AzureRmDnsRecordSet -Zone $dnszone -Name "sip" -RecordType CNAME -Ttl $ttl -DnsRecords (New-AzureRmDnsRecordConfig -cname "sipdir.online.lync.com")
New-AzureRmDnsRecordSet -Zone $dnszone -Name "lyncdiscover" -RecordType CNAME -Ttl $ttl -DnsRecords (New-AzureRmDnsRecordConfig -cname "webdir.online.lync.com")
New-AzureRmDnsRecordSet -Zone $dnszone -Name "msoid" -RecordType CNAME -Ttl $ttl -DnsRecords (New-AzureRmDnsRecordConfig -cname "clientconfig.microsoftonline-p.net")
New-AzureRmDnsRecordSet -Zone $dnszone -Name "enterpriseregistration" -RecordType CNAME -Ttl $ttl -DnsRecords (New-AzureRmDnsRecordConfig -cname "enterpriseregistration.windows.net")
New-AzureRmDnsRecordSet -Zone $dnszone -Name "enterpriseenrollment" -RecordType CNAME -Ttl $ttl -DnsRecords (New-AzureRmDnsRecordConfig -cname "enterpriseenrollment.manage.microsoft.com")
#
# Modifies the existing TXT record
$txtrecord = Get-AzureRmDnsRecordSet -Zone $dnszone -Name "@" -RecordType TXT
Add-AzureRmDnsRecordConfig -RecordSet $txtrecord -Value "v=spf1 include:spf.protection.outlook.com -all"
Set-AzureRmDnsRecordSet -RecordSet $txtrecord
#
# SRV records
New-AzureRmDnsRecordSet -Zone $dnszone -Name "_sip._tls" -RecordType SRV -Ttl $ttl -DnsRecords (New-AzureRmDnsRecordConfig -Priority 100 -Weight 1 -Port 443 -Target sipdir.online.lync.com)
New-AzureRmDnsRecordSet -Zone $dnszone -Name "_sipfederationtls._tcp" -RecordType SRV -Ttl $ttl -DnsRecords (New-AzureRmDnsRecordConfig -Priority 100 -Weight 1 -Port 5061 -Target sipfed.online.lync.com)
#
# MX records - THIS CHANGES THE MAIL FLOW!
#
$exchadr = ($zonename -replace "\.","-")
$exchadr +=".mail.protection.outlook.com"
$mxrecords = @()
$mxrecords = New-AzureRmDnsRecordConfig -Exchange $exchadr -Preference 0
New-AzureRmDnsRecordSet -Zone $dnszone -Name "@" -RecordType MX -Ttl $ttl -DnsRecords $mxrecords
#
# Select one or several DNS records and delete them from zone
Get-AzureRmDnsRecordSet -Zone $dnszone | Out-GridView -Title "Select record to delete" -OutputMode Multiple | Remove-AzureRmDnsRecordSet
#
}