. "$PSScriptRoot\Common.ps1"
$ErrorActionPreference = 'SilentlyContinue'
Write-Output-Format "[yasb] Killing Process"
Get-Process -Name "pythonw3.9" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Wait-Process -Name "pythonw3.9" -ErrorAction SilentlyContinue

Start-Sleep 2

Write-Output-Format "[yasb] Checking for Processes"
Get-Process-Command -Name "pythonw3.9"