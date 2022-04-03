Write-Output "--------------------------------------------------"
Write-Output " Stopping Komorebi"
Write-Output "--------------------------------------------------"
Invoke-Expression -Command "C:\Users\eric\.cargo\bin\komorebic.exe stop"
Sleep 1
Write-Output "--------------------------------------------------"
Write-Output " Forcefully Stopping Komorebi"
Write-Output "--------------------------------------------------"
Invoke-Expression -Command "C:\ProgramData\chocolatey\bin\pskill.exe /t komorebi"
Sleep 1
Invoke-Expression -Command "C:\ProgramData\chocolatey\bin\pskill.exe /t komorebi"
Sleep 1
Write-Output "--------------------------------------------------"
Write-Output " Starting Komorebi
Write-Output "--------------------------------------------------"
Invoke-Expression -Command "C:\Users\eric\.cargo\bin\komorebic.exe start"
Sleep 1
Write-Output "--------------------------------------------------"
Write-Output " Starting AutoHotKey
Write-Output "--------------------------------------------------"
Invoke-Expression -Command "start C:\Users\eric\Rice\windowsbox\ahk\ahk-init.ahk"
Sleep 1