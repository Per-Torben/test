$a=@(1,2,3,1,2)
$ht = @{}
$a | foreach {$ht["$_"] += 1}
$ht.keys | where {$ht["$_"] -gt 1} | foreach {write-host "Duplicate element found $_" }



$users = Import-Csv C:\Scripts\test\Uke50-Mørkvedmarka.csv -Delimiter ";" -Encoding UTF8
$DuplicateCheck = @()
foreach ($u in $users){
    IF ($test -notcontains $u.logon){
        $test += $u.logon
    }
    ELSE {
        Write-Host "Duplicate found $($u.logon)"
    }
}


$a=1
while ($true) {
    IF ($a -eq 5){
        Break
    }
    ELSE{
        $a
        $a=$a+1
    }
}



(Get-Mailbox -SoftDeletedMailbox Rebeca.Marin.Barbero@bodo.kommune.no).ExchangeGuid 

(Get-Mailbox Rebeca.Marin.Barbero@bodo.kommune.no).ExchangeGuid 