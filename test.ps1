#Test

$runscript = $true
if ($runscript -eq $false)
{
Write-Host -ForegroundColor Red "Do NOT run this script non-interactively! Run from editor"
return
}
Write-Host -ForegroundColor Red "Hello"
Write-Host -ForegroundColor Green "Bye!"
