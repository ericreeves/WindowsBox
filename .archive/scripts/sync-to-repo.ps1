. "$PSScriptRoot\Config.ps1"

Write-Host "--- Syncing to Repo Folder"
foreach ($App in $Configs )
{
	SyncConfig -Source $($App.host_folder) -Destination $($App.repo_folder) -Files $($App.files)
}