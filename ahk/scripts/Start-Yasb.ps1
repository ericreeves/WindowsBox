. "$PSScriptRoot\Common.ps1"
$ErrorActionPreference = 'SilentlyContinue'
Write-Output-Format "[yasb] Starting yasb"
Start-Process -FilePath "$Python_Bin_Folder\pythonw3.9.exe" -ArgumentList "src/main.py" -WorkingDirectory "$Yasb_Folder" -WindowStyle Hidden

Wait-For-Process -Name "pythonw3.9"

Write-Output-format "[ahk] Starting AutoHotKey"
"AutoHotKey.exe $AHK_Folder\$AHK_Filename"