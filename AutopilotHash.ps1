$Path = "C:\AutopilotDevices.csv"

# Check if CSV exists; if not, write official Intune headers
if (-not (Test-Path $Path)) {
    "Device Serial Number,Windows Product ID,Hardware Hash" | Out-File -FilePath $Path -Encoding utf8
}

# Collect Serial Number & Hardware Hash
$Serial = (Get-CimInstance -ClassName Win32_BIOS).SerialNumber
$Hash   = (Get-CimInstance -Namespace "root/cimv2/mdm/dmmap" -ClassName "MDM_DevDetail_Ext01" -Filter "InstanceID='Ext' AND ParentID='./DevDetail'").DeviceHardwareData

# Append device row to CSV
"$Serial,,$Hash" | Out-File -FilePath $Path -Encoding utf8 -Append

Write-Host "Added $Serial to $Path" -ForegroundColor Green
