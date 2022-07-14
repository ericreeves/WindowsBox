. "$PSScriptRoot\Common.ps1"

# Write-Output "--- Current yasb Processes"
# Get-Process-Command -Name "pythonw"

# Write-Output "--- Killing yasb"
# Get-Process -Name "pythonw" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
# Wait-Process -Name "pythonw" -ErrorAction SilentlyContinue

Write-Output "--- Current komorebi Processes"
Get-Process-Command -Name "komorebi"

Write-Output "--- Killing komorebi"
Get-Process -Name "komorebi" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Wait-Process -Name "komorebi" -ErrorAction SilentlyContinue

Write-Output "--- Starting AutoHotKey "
Invoke-Item "$AHK_Folder\$AHK_Filename"

Wait-For-Process -Name "komorebi"
Get-Process-Command -Name "komorebi"

# Wait-For-Process -Name "pythonw"
# Get-Process-Command -Name "pythonw"