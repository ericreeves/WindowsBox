. "$PSScriptRoot\common.ps1"

#
# WinGet Packages to Install
#
$WingetApps = @(
    "Notepads App",
    "Lexikos.AutoHotkey",
    "1Password",
    "LGUG2Z.komorebi",
    "TranslucentTB",
    "7zip.7zip",
    "NuGet Package Explorer",
    "sysintenals"
)

#-------------------------------------------------------------------------------
#--- Winget Apps ---
#-------------------------------------------------------------------------------
Write-Banner -Text "Installing Winget Packages"
foreach ($app in $WingetApps) {

    winget install --accept-package-agreements --accept-source-agreements "$app"
}