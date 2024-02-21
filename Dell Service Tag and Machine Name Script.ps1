# Retrieve laptop serial number from BIOS
$biosInfo = Get-WmiObject -Class Win32_BIOS
$laptopServiceTag = $biosInfo.SerialNumber

# If laptop serial number from BIOS is not available, try from Win32_ComputerSystem
if ([string]::IsNullOrEmpty($laptopServiceTag)) {
    $laptopInfo = Get-WmiObject -Class Win32_ComputerSystem
    $laptopServiceTag = $laptopInfo.SerialNumber
}

# Retrieve laptop name
$laptopName = $env:COMPUTERNAME

# Retrieve monitor service tag and make/model
$monitorInfo = Get-WmiObject -Namespace root\wmi -Class WmiMonitorID
$monitorServiceTag = [System.Text.Encoding]::ASCII.GetString($monitorInfo.SerialNumberID)
$monitorMake = [System.Text.Encoding]::ASCII.GetString($monitorInfo.ManufacturerName)
$monitorModel = [System.Text.Encoding]::ASCII.GetString($monitorInfo.UserFriendlyName)

# Display the retrieved information
Write-Host "Laptop Service Tag: $laptopServiceTag"
Write-Host "Laptop Name: $laptopName"
Write-Host "Monitor Service Tag: $monitorServiceTag"
Write-Host "Monitor Make: $monitorMake"
Write-Host "Monitor Model: $monitorModel"

# Pause to keep the window open
Pause
