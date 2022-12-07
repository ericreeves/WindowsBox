. "$PSScriptRoot\Config.ps1"

Write-Host "--- Installing to Host"
foreach ($App in $Configs )
{
	SyncConfig -Source $($App.repo_folder) -Destination $($App.host_folder) -Files $($App.files)
}