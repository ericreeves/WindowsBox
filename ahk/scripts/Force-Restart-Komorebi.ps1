. "$PSScriptRoot\Common.ps1"

Write-Output "--- Current komorebi Processes"
Get-Process-Command -Name "komorebi"

Write-Output "--- Killing yasb"
Get-Process -Name "pythonw3.9" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Wait-Process -Name "pythonw3.9" -ErrorAction SilentlyContinue

Write-Output "--- Killing komorebi"
Get-Process -Name "komorebi" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Wait-Process -Name "komorebi" -ErrorAction SilentlyContinue

Write-Output "--- Starting AutoHotKey "
Invoke-Item "$AHK_Folder\$AHK_Filename"

Wait-For-Process -Name "komorebi"
Get-Process-Command -Name "komorebi"

Wait-For-Process -Name "pythonw3.9"
Get-Process-Command -Name "pythonw3.9"