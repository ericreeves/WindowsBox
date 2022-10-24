#
# WinGet Packages to Install
#
$apps = @(
    @{name = "gerardog.gsudo" },
    @{name = "JackieLiu.NotepadsApp" },
    @{name = "Microsoft.PowerToys" },
    @{name = "Lexikos.AutoHotkey" },
    @{name = "1Password" },
    @{name = "LGUG2Z.komorebi" },
    @{name = "TranslucentTB" },
    @{name = "7zip.7zip" },
    @{name = "gsass1.NTop" },
    @{name = "Microsoft.NuGet"; admin = "true" },
    @{name = "Microsoft.Sysinternals.ProcessMonitor"; admin = "true" },
    @{name = "Microsoft.Sysinternals.ProcessExplorer"; admin = "true" },
    @{name = "Microsoft.Sysinternals.Autoruns"; admin = "true" },
    @{name = "Microsoft.VisualStudioCode" },
    @{name = "Tailscale" },
    @{name = "Keybase" },
    @{name = "Zoom.Zoom" },
    @{name = "Notion.Notion" },
    @{name = "QL-Win.QuickLook" },
    # @{name = "GIMP.GIMP" },
    # @{name = "OBSProject.OBSStudio" },
    @{name = "Valve.Steam" },
    @{name = "Discord.Discord" },
    # @{name = "EpicGames.EpicGamesLauncher" },
    @{name = "Nvidia.GeForceExperience" },
    @{name = "Audacity.Audacity" },
    # @{name = "Playnite.Playnite" },
    @{name = "Microsoft.WindowsTerminal" },
    @{name = "GitHub.GitHubDesktop" },
    @{name = "MoonlightGameStreamingProject.Moonlight" },
    @{name = "Ferdium.Ferdium.Nightly" },
    @{name = "Flameshot.Flameshot" },
    @{name = "SomePythonThings.WingetUIStore" },
    @{name = "Google.Chrome"; force = "true" },
    @{name = "Git.Git"; interactive = "true" },
    @{name = "GnuPG.Gpg4win"; interactive = "true" },
    @{name = "Logitech.Options" },
    @{name = "Microsoft.dotnetRuntime.6-x64" },
    @{name = "rickbutton.workspacer.beta"; force = "true" },
    @{name = "Spotify.Spotify"; force = "true" },
    @{name = "SyncTrayzor.SyncTrayzor" },
    @{name = "WinDirStat.WinDirStat" },
    @{name = "AltSnap.AltSnap" },
    @{name = "SlackTechnologies.Slack" }
)

#-------------------------------------------------------------------------------
#--- Winget Apps ---
#-------------------------------------------------------------------------------
# winget manager

Write-Output "Installing apps..."
Write-Output ""

Foreach ($app in $apps) {
    $listApp = winget list --exact -q $app.name
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-host "Installing:" $app.name
        if ($null -ne $app.source) {
            winget install --exact --silent $app.name --source $app.source
        }
        elseif ($null -ne $app.force) {
            winget install --exact --silent $app.name --force
        }
        elseif ($null -ne $app.interactive) {
            winget install --exact --interactive $app.name
        }
        elseif ($null -ne $app.admin) {
            gsudo winget install --exact $app.name
        }
        else {
            winget install --exact --silent $app.name
        }
    }
    else {
        Write-host "Skipping install of" $app.name
    }
}

Write-Output ""
Write-Output "Done!"

Write-Output ""
Write-Output "Updating apps..."

Write-Output ""
winget upgrade --all

Write-Output ""
Write-Output "Done!"

Write-Output ""
Write-Host -NoNewLine 'Press any key to exit...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');