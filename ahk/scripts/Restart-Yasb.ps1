. "$PSScriptRoot\Common.ps1"

Write-Output "--- Current yasb Processes"
Get-Process-Command -Name "pythonw"

Write-Output "--- Killing yasb"
Get-Process -Name "pythonw" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Wait-Process -Name "pythonw" -ErrorAction SilentlyContinue

Write-Output "--------------------------------------------------"
Write-Output " Starting yasb "
Write-Output "--------------------------------------------------"
Start-Process -FilePath "$Python_Bin_Folder\pythonw.exe" -WorkingDirectory "$Yasb_Folder" -ArgumentList "src/main.py" -WindowStyle Hidden
Wait-For-Process -Name "pythonw"
Get-Process-Command -Name "pythonw"