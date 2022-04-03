#
# Set-Wallpaper originally by Jose Espisita: https://www.joseespitia.com/2017/09/15/set-wallpaper-powershell-function/
#
# With some modifications by Joseph McEvoy: https://github.com/JosephMcEvoy/PowerShell/blob/master/Misc/randomWallpaper.ps1
#
# And some more modifications by Eric Reeves
#

param ($WallPaperPath)

function Get-Random-Image {
	param (
		[string]$WallPaperPath = "C:\Users\eric\Pictures\Wallpaper",
		[string]$Path = "$PSScriptRoot"
	)
	$Wallpaper = Get-ChildItem -Path $WallPaperPath -recurse | Where-Object {($_.extension -eq ".jpg" -or $_.extension -eq ".png" -or $_.extension -eq ".jpeg")} | Get-Random -Count 1 | ForEach-Object { $_.FullName } 
	Write-Output "$Wallpaper"
}

# Set Wallpaper Only on 2nd Monitor
# Get-Monitor | Select-Object -skip 1 | Select-Object -First 1 | Set-WallPaper -Path C:\Wallpapers\nature.jpg

#$WallPaper = Get-Random-Image -WallPaperPath $WallPaperPath
$WallPaper = Get-Random-Image -WallPaperPath $WallPaperPath
$WallPaper | Out-File "c:\Users\eric\Pictures\Wallpaper\current-wallpaper.txt"
Get-Monitor | Set-WallPaper -Path $WallPaper