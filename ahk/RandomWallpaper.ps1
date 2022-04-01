#
# Set-Wallpaper originally by Jose Espisita: https://www.joseespitia.com/2017/09/15/set-wallpaper-powershell-function/
#
# With some modifications by Joseph McEvoy: https://github.com/JosephMcEvoy/PowerShell/blob/master/Misc/randomWallpaper.ps1
#
# And some more modifications by Eric Reeves
#
function Set-WallPaper {
	<#
		.SYNOPSIS
		Applies a specified wallpaper to the current user's desktop
		
		.PARAMETER Image
		Provide the exact path to the image

		.PARAMETER Style
		Provide wallpaper style (Example: Fill, Fit, Stretch, Tile, Center, or Span)

		.EXAMPLE
		Set-WallPaper -Image "C:\Wallpaper\Default.jpg"
		Set-WallPaper -Image "C:\Wallpaper\Background.jpg" -Style Fit
	#>

	param (
		[parameter(Mandatory = $True, ValueFromPipeline = $True)]
		# Provide path to image
		[string]$Image,
		# Provide wallpaper style that you would like applied
		[parameter(Mandatory = $False)]
		[ValidateSet('Fill', 'Fit', 'Stretch', 'Tile', 'Center', 'Span')]
		[string]$Style = 'Fill'
	)

	$WallpaperStyle = Switch ($Style) {
		"Fill" { "10" }
		"Fit" { "6" }
		"Stretch" { "2" }
		"Tile" { "0" }
		"Center" { "0" }
		"Span" { "22" }
	}

	if ($Style -eq "Tile") {
		New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force | Out-Null
		New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 1 -Force | Out-Null
	}
    else {
		New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force | Out-Null
		New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 0 -Force | Out-Null
	}
	Add-Type -TypeDefinition @" 
	using System; 
	using System.Runtime.InteropServices;
	public class Params
	{ 
		[DllImport("User32.dll",CharSet=CharSet.Unicode)] 
		public static extern int SystemParametersInfo (Int32 uAction, Int32 uParam, String lpvParam, Int32 fuWinIni);
	}
"@ 
		$SPI_SETDESKWALLPAPER = 0x0014
		$UpdateIniFile = 0x01
		$SendChangeEvent = 0x02
		$fWinIni = $UpdateIniFile -bor $SendChangeEvent
		[Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)
		Write-Output $Image
	}
	function Get-Image {
		param (
			[string]$WallpaperFolder = "C:\Users\eric\Wallpaper",
			[string]$Path = "$PSScriptRoot"
		)
		$Wallpaper = Get-ChildItem -Path $WallpaperFolder -recurse | Where-Object {($_.extension -eq ".jpg" -or $_.extension -eq ".png" -or $_.extension -eq ".jpeg")} | Get-Random -Count 1 | ForEach-Object { $_.FullName } 
		Write-Output "$Wallpaper"
	}
	
$WallPaper = Get-Image
$WallPaper | Out-File "c:\Users\eric\Wallpaper\current-wallpaper.txt"
$WallPaper | Set-WallPaper