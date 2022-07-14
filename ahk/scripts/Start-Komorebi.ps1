. "$PSScriptRoot\Common.ps1"

Write-Output "--------------------------------------------------"
Write-Output " Starting Komorebi "
Write-Output "--------------------------------------------------"
Start-Process -FilePath "$Komorebi_Bin_Folder\komorebi.exe" -WindowStyle Hidden
Wait-For-Process -Name "komorebi"

Sleep-Sleep 2

Write-Output "--------------------------------------------------"
Write-Output " Starting yasb "
Write-Output "--------------------------------------------------"
Start-Process -FilePath "$Python_Bin_Folder\pythonw.exe" -WorkingDirectory "$Yasb_Folder" -ArgumentList "src/main.py" -WindowStyle Hidden
Wait-For-Process -Name "pythonw"