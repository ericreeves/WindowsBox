#
#-------------------------------------------------------------------------------
#------------------------- Eric's BoxStarter Magic -----------------------------
#-------------------------------------------------------------------------------
#
# Borrowed from piles of other BoxStarter scripts, assembled the way I like it.
#
#

#-------------------------------------------------------------------------------
#--- User Configuration ---
#-------------------------------------------------------------------------------

#
# Git Configuration
#
$GitEmail = "eric@alluvium.com"
$GitUserName = "Eric Reeves"

#
# Chocolately Apps to Install
#
$ChocoApps = @(
    "chocolateygui",
    "1password",
    "Firefox",
    "vivaldi",
    "googlechrome",
    "ferdi",
    "chezmoi",
    "vscode",
    "alacritty",
    "7zip",
    "github-desktop",
    "nvidia-geforce-now",
    "greenshot",
    "tailscale",
    "synctrayzor",
    "signal",
    "obs-studio",
    "obs-virtualcam",
    "winaero-tweaker",
    "mpvnet.install",
    "keybase",
    "autohotkey",
    "vlc",
    "sysinternals",
    "hwinfo",
    "notepadplusplus.install",
    "nuget.commandline",
    "NugetPackageExplorer",
    "rocolatey",
    "filezilla",
    "paint.net",
    #"mousewithoutborders",
    "pingplotter",
    # "eartrumpet",
    "windirstat",
    "spotify",
    "joplin",
    "puretext",
    "quickview",
    "powertoys",
    "discord",
    "betterdiscord",
    "irfanview"
    )

#
# Chocolately Packages to Install, Ignoring Checksum (workaround for broken packages)
#
$ChocoAppsIgnoreChecksum = @(
    "steam-client"
)

#
# Chocolatey Packagse to Pin (Applications that update themselves should be pinned, so Chocolately leaves them alone)
#
$ChocoPin = @(
    "Firefox",
    "vscode",
    "ferdi"
)

#-------------------------------------------------------------------------------
#--- END OF USER CONFIGRATION ---
#-------------------------------------------------------------------------------
#--- DO NOT MODIFY BELOW ---
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
#--- Functions ---
#-------------------------------------------------------------------------------
function Write-Banner {
    param (
        $Text
    )
    Write-Host "--------------------------------------------------------------------------------" -foregroundcolor green
    Write-Host "$Text" -foregroundcolor green
    Write-Host "--------------------------------------------------------------------------------" -foregroundcolor green
}


#-------------------------------------------------------------------------------
#--- Setup and Run Windows Update ---
#-------------------------------------------------------------------------------
$Boxstarter.RebootOk=$true

Write-Banner -Text "Setting Up Windows Update"
Install-Packageprovider -name nuget -minimumversion 2.8.5.201 -force
Install-Module -name pswindowsupdate -allowclobber

Write-Banner -Text "Installing Windows Updates... (Computer may reboot...)"
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AcceptEula

#-------------------------------------------------------------------------------
#--- Windows Subsystems/Features ---
#-------------------------------------------------------------------------------
# choco install Microsoft-Hyper-V-All -source WindowsFeatures -y
choco install Microsoft-Windows-Subsystem-Linux -source WindowsFeatures -y
# choco install NetFx3 -source windowsfeatures
# choco install Containers -source windowsfeatures

#-------------------------------------------------------------------------------
#--- Uninstall unecessary applications that come with Windows out of the box ---
#-------------------------------------------------------------------------------
Write-Banner -Text "Uninstalling Stock Windows Cruft"
Get-AppxPackage Facebook.Facebook | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage TuneIn.TuneInRadio | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.MinecraftUWP | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage KeeperSecurityInc.Keeper | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage 2FE3CB00.PicsArt-PhotoStudio | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage 9E2F88E3.Twitter | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name *Twitter | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name *MarchofEmpires | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name king.com.* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.3DBuilder | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name *Bing* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name *BubbleWitch* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name king.com.CandyCrush* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name microsoft.windowscommunicationsapps | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name DellInc.PartnerPromo | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.SkypeApp | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.MixedReality.Portal | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.Microsoft3DViewer | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name Microsoft.Getstarted | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage -AllUser -Name SpotifyAB.SpotifyMusic | Remove-AppxPackage -ErrorAction SilentlyContinue

Get-AppxPackage Microsoft.3DBuilder | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *Autodesk* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *BubbleWitch* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage king.com.CandyCrush* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.CommsPhone | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *Dell* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *Dropbox* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *Facebook* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *Keeper* | Remove-AppxPackage -ErrorAction SilentlyContinue

Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *McAfee* | Remove-AppxPackage -ErrorAction SilentlyContinue
# Uninstall McAfee Security App
$mcafee = Get-ChildItem "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | ForEach-Object { Get-ItemProperty $_.PSPath } | Where-Object { $_ -match "McAfee Security" } | Select-Object UninstallString
if ($mcafee) {
	$mcafee = $mcafee.UninstallString -Replace "C:\Program Files\McAfee\MSC\mcuihost.exe",""
	Write-Banner -Text "Uninstalling McAfee"
	start-process "C:\Program Files\McAfee\MSC\mcuihost.exe" -arg "$mcafee" -Wait
}
# Mail & Calendar
Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *Minecraft* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *Xbox* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *Netflix* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.OneConnect | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.People | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *Plex* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *Solitaire* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.Office.Sway | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage *Twitter* | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage -ErrorAction SilentlyContinue
Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage -ErrorAction SilentlyContinue

#-------------------------------------------------------------------------------
#--- Windows Settings ---
#-------------------------------------------------------------------------------

Write-Banner -Text "Configuring Windows Settings"
# Disable Xbox Gamebar Tips - https://boxstarter.org/WinConfig
Disable-GameBarTips

# Disable BingSearch - https://boxstarter.org/WinConfig
Disable-BingSearch

# No SMB1 - https://blogs.technet.microsoft.com/filecab/2016/09/16/stop-using-smb1/
Disable-WindowsOptionalFeature -Online -FeatureName smb1protocol

# Better File Explorer
Set-WindowsExplorerOptions -EnableShowProtectedOSFiles  -EnableShowFileExtensions -EnableShowFullPathInTitleBar -EnableShowHiddenFilesFoldersDrives

# Start Menu: Disable Bing Search Results
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 0
# To Restore (Enabled):
# Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 1

# Change Explorer home screen back to "This PC"
# Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Type DWord -Value 1
# Change it back to "Quick Access" (Windows 10 default)
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Type DWord -Value 2

# These make "Quick Access" behave much closer to the old "Favorites"
# Disable Quick Access: Recent Files
# Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowRecent -Type DWord -Value 0
# Disable Quick Access: Frequent Folders
# Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowFrequent -Type DWord -Value 0
# To Restore:
# Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowRecent -Type DWord -Value 1
# Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowFrequent -Type DWord -Value 1

# Install PowerShell Help (https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/update-help?view=powershell-7.2)
Update-Help -ErrorAction SilentlyContinue

#-------------------------------------------------------------------------------
#--- Chocolatey Apps ---
#-------------------------------------------------------------------------------
Write-Banner -Text "Installing Chocolatey Packages"

# We run upgrade which will install the software if it doesn't exist or upgrade it if it does.
if ($ChocoApps.Count -gt 0) {
    # Install a ton of other crap I use or like, update $ChocoInsalls to suit your needs of course
    $ChocoApps | Foreach-Object {
        try {
            choco upgrade -y $_ --cacheLocation "$($env:userprofile)\AppData\Local\Temp\chocolatey"
        }
        catch {
            Write-Warning "Unable to install software package with Chocolatey: $($_)"
        }
    }
}
else {
    Write-Output 'There were no packages to install!'
}

Write-Banner -Text "Installing Chocolatey Packages (Ignoring Checksums)"
foreach ($app in $ChocoAppsIgnoreChecksum) {
    choco upgrade "$app" -y --ignore-checksums --cacheLocation "$($env:userprofile)\AppData\Local\Temp\chocolatey"
}

Write-Banner -Text "Pinning Self-Updating Chocolatey Packages"
foreach ($pinapp in $ChocoPin) {
    choco pin add -n="$pinapp"
}

#-------------------------------------------------------------------------------
#--- Git ---
#-------------------------------------------------------------------------------
Write-Banner -Text "Installing and Configuring Git for Windows"
choco install git -y --params "/GitAndUnixToolsOnPath"
refreshenv

git config --global user.email "$GitEmail"
git config --global user.name "$GitUserName"
git config --global core.autocrlf true

#-------------------------------------------------------------------------------
#--- Restore Temporary Settings ---
#-------------------------------------------------------------------------------
Write-Banner -Text "Restoring Temporary Settings"
Enable-UAC
Enable-MicrosoftUpdate

Write-Host -Text "Invoking Reboot if Pending"
if (Test-PendingReboot) { Invoke-Reboot }

Write-Banner -Text "Cleaning Up Temporary Files"
Remove-Item C:\eula*.txt
Remove-Item C:\install.*
Remove-Item C:\vcredist.*
Remove-Item C:\vc_red.*

#-------------------------------------------------------------------------------
#--- Install Ubuntu in WSL if Needed
#-------------------------------------------------------------------------------
if ( ! (wsl -l | Where-Object {$_.Replace("`0","") -match '^Ubuntu'})) { 
    Write-Banner -Text "Enabling and Installing WSL"
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
    choco upgrade -y wsl
    wsl --set-default-version 2
    wsl --install -d Ubuntu
} else {
    Write-Banner -Text "WSL (Ubuntu) Already Installed"
}

#-------------------------------------------------------------------------------
#--- Done! Reboot!
#-------------------------------------------------------------------------------
Write-Host "================================================================================" -foregroundcolor green
Read-Host -Prompt "Setup is Complete! Press [ENTER] to Reboot"
Restart-Computer
