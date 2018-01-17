# Test 1 function
# Written by: Per-Torben Sørensen
function Get-TeslaRange () {
    [CmdLetBinding()]
    # Parameters 
    Param (
        [Parameter(Mandatory = $True,Position = 0)]    
        [int] $AvgConsumption,
        [Parameter(Mandatory = $True, Position = 1)]
        [int] $Capacity)
    # End of parameters
        $Capacity = $Capacity * 1000
        $range = $Capacity / $AvgConsumption
        $range
}

Get-TeslaRange -AvgConsumption 250 -Capacity 72







$teslacred = Get-Credential
function Get-SoC {
    $batterystate = Get-Tesla -Command charge_state
    $batterystate.battery_level
    $batterystate.ideal_battery_range
    #Write-Host "This is line 2"
}


#$Test2 = Get-Tesla -Command charge_state
#$Test.charge_limit_soc
#$Test.battery_range.GetType()

$UsablekWh = 69
$TestkWh = $Test.battery_level * $UsablekWh / 100
$RatedCons = ($TestkWh / ($Test.battery_range * 1.609)) * 1000
$TypicalCons = ($TestkWh / ($Test.ideal_battery_range * 1.609)) * 1000
$EstimatedCons = ($TestkWh / ($Test.est_battery_range * 1.609)) * 1000
Write-Host    
Write-Host "Rated consumption is $([System.Math]::Round($RatedCons,2)) wh/km"
Write-Host "Typical consumption is $([System.Math]::Round($TypicalCons,2)) wh/km"
Write-Host "Estimated (your average?) consumption is $([System.Math]::Round($EstimatedCons,2)) wh/km"

get-soc