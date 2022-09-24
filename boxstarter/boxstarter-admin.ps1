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
# choco install Microsoft-Windows-Subsystem-Linux -source WindowsFeatures -y
# choco install NetFx3 -source windowsfeatures
# choco install Containers -source windowsfeatures

#-------------------------------------------------------------------------------
#--- Powershell Settings ---
#-------------------------------------------------------------------------------
Write-Banner -Text "Configuring Powershell Settings"

# Trust PSGallery
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

# Update Powershellget
Install-Module PowershellGet -Force -AllowClobber   

# Install FP.SetWallpaper - https://github.com/federico-paolillo/set-wallpaper
Install-Module -Name FP.SetWallpaper -AcceptLicense

# Update Powershell
winget install --id Microsoft.Powershell --source winget

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
#--- Git ---
#-------------------------------------------------------------------------------
# Write-Banner -Text "Installing and Configuring Git for Windows"
# choco install git -y --params "/GitAndUnixToolsOnPath"
# refreshenv

# git config --global user.email "$GitEmail"
# git config --global user.name "$GitUserName"
# git config --global core.autocrlf true

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
# if ( ! (wsl -l | Where-Object {$_.Replace("`0","") -match '^Ubuntu'})) { 
#     Write-Banner -Text "Enabling and Installing WSL"
#     Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
#     choco upgrade -y wsl
#     wsl --set-default-version 2
#     wsl --install -d Ubuntu
# } else {
#     Write-Banner -Text "WSL (Ubuntu) Already Installed"
# }

#-------------------------------------------------------------------------------
#--- Done! Reboot!
#-------------------------------------------------------------------------------
Write-Host "================================================================================" -foregroundcolor green
# Read-Host -Prompt "Setup is Complete! Press [ENTER] to Reboot"
# Restart-Computer
