. "$PSScriptRoot\Common.ps1"

Write-Output "--- Current yasb Processes"
Get-Process-Command -Name "pythonw3.9"

Write-Output "--- Killing yasb"
Get-Process -Name "pythonw3.9" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Wait-Process -Name "pythonw3.9" -ErrorAction SilentlyContinue

Write-Output "--------------------------------------------------"
Write-Output " Starting yasb "
Write-Output "--------------------------------------------------"
Start-Process -FilePath "$Python_Bin_Folder\pythonw3.exe" -WorkingDirectory "$Yasb_Folder" -ArgumentList "src/main.py" -WindowStyle Hidden
Wait-For-Process -Name "pythonw3.9"
Get-Process-Command -Name "pythonw3.9"