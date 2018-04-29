
Import-Module tesla
$token = Get-TeslaToken -Credential (Get-Credential)
$vehicle = Get-TeslaVehicle -Token $token
Get-Command -Module Tesla
Get-TeslaVehicleDetail -Vehicle $vehicle -token $token
Get-TeslaVehicleSummary -Vehicle $vehicle -Token $token
Get-TeslaVehicleChargeState -Vehicle $vehicle -Token $token
Get-TeslaVehicleDriveState -Vehicle $vehicle -Token $token