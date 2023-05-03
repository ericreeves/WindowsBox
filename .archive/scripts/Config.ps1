$Configs =
@(
	@{
		repo_folder = "fancywm";
		host_folder = "$HOME\AppData\Local\Packages\2203VeselinKaraganev.FancyWM_9x2ndwrcmyd2c\LocalCache\Roaming\FancyWM";
		files       = "settings.json";
	};
	@{
		repo_folder = "terminal";
		host_folder = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
		files       = "settings.json";
	};

	# @{
	# 	repo_folder = "glazewm";
	# 	host_folder = "$HOME\.glaze-wm";
	# 	files       = "config.yaml";
	# };
	# @{
	# 	repo_folder = "workspacer";
	# 	host_folder = "$HOME\.workspacer";
	# 	files       = "workspacer.config.csx,alacritty.yml";
	# };
	# @{
	# 	repo_folder = "komorebi";
	# 	host_folder = "$HOME\.config\komorebi";
	# 	files       = "applications.yaml,eric-primary.json,komorebi.ahk,komorebi.generated.ahk,komorebic.lib.ahk,overrides.yaml,start-komorebi.ps1"
	# };
	# @{
	# 	repo_folder = "ueli";
	# 	host_folder = "$HOME\AppData\Roaming\ueli";
	# 	files       = "config.json,Preferences"
	# };
)


function SyncConfig()
{

    Param
    (
        [Parameter(Mandatory = $true)] [string] $Source,
        [Parameter(Mandatory = $true)] [string] $Destination,
        [Parameter(Mandatory = $true)] [array] $Files
    ) 

	$FileList = $Files -split ","

	if(-not(Test-Path "$Destination"))
	{
		New-Item -ItemType Directory -Force -Path "$Destination"
	}
	robocopy "$Source" "$Destination" $FileList

}