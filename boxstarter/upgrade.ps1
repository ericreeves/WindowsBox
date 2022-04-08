Write-Output "--- Updating Winget"
winget upgrade --all  --accept-package-agreements --accept-source-agreements

Write-Output "--- Updating Chocolatey"
sudo choco upgrade all

Write-Output "--- Updating Scoop"
scoop update *

