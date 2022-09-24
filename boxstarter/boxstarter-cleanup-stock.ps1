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