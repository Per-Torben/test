#Get-Tesla commands:
#climate_state
#charge_state
#gui_settings
#drive_state
#vehicle_state
#vehicles
#Set-Tesla commands:
#mobile_enabled
#auto_conditioning_start
#auto_conditioning_stop
#door_lock
#door_unlock
#sun_roof_control?state=close
#sun_roof_control?state=comfort
#sun_roof_control?state=vent
#charge_stop
#charge_start

$teslacred = Get-Credential

Connect-Tesla -Credential $teslacred

get-tesla -Command vehicles    

Get-Tesla -Command charge_state