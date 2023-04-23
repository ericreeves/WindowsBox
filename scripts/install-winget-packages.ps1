#
# WinGet Packages to Install
#
$apps = @(
    @{ name = "1Password" }
    # @{ name = "7zip.7zip" }
    @{ name = "9P1741LKHQS9" }
    @{ name = "AgileBits.1Password.CLI" }
    @{ name = "AltSnap.AltSnap" }
    @{ name = "Audacity.Audacity" }
    @{ name = "Discord.Discord" }
    @{ name = "Ferdium.Ferdium" }
    @{ name = "File-New-Project.EarTrumpet" }
#    @{ name = "Flameshot.Flameshot" }
    @{ name = "gerardog.gsudo" }
    @{ name = "Giorgiotani.Peazip" }
    @{ name = "Git.Git"; interactive = "true" }
    @{ name = "GitHub.GitHubDesktop" }
    @{ name = "GnuPG.Gpg4win"; interactive = "true" }
    @{ name = "Google.Chrome"; force = "true" }
    @{ name = "gsass1.NTop" }
    @{ name = "JackieLiu.NotepadsApp" }
    @{ name = "JanDeDobbeleer.OhMyPosh" }
    @{ name = "Keybase" }
    @{ name = "Lexikos.AutoHotkey" }
    @{ name = "MicaForEveryone.MicaForEveryone" }
    @{ name = "Microsoft.dotnetRuntime.6-x64" }
    @{ name = "Microsoft.PowerShell" }
    @{ name = "Microsoft.PowerToys" }
    @{ name = "Microsoft.Sysinternals.Autoruns"; admin = "true" }
    @{ name = "Microsoft.Sysinternals.ProcessExplorer"; admin = "true" }
    @{ name = "Microsoft.Sysinternals.ProcessMonitor"; admin = "true" }
    @{ name = "Microsoft.Teams" }
    @{ name = "Microsoft.VisualStudioCode" }
    @{ name = "Microsoft.WindowsTerminal" }
    @{ name = "MikeFarah.yq" }
    # @{ name = "Notion.Notion" }
    @{ name = "OBSProject.OBSStudio" }
    @{ name = "QL-Win.QuickLook" }
    # @{ name = "SlackTechnologies.Slack" }
    @{ name = "SomePythonThings.WingetUIStore" }
    @{ name = "Spotify.Spotify"; force = "true" }
    @{ name = "StartIsBack.StartAllBack" }
    @{ name = "stedolan.jq" }
    @{ name = "stnkl.EverythingToolbar" }
    @{ name = "SyncTrayzor.SyncTrayzor" }
    @{ name = "Tailscale" }
    # @{ name = "TranslucentTB" }
    @{ name = "Valve.Steam" }
    @{ name = "voidtools.Everything" }
    @{ name = "WinDirStat.WinDirStat" }
    @{ name = "Zoom.Zoom" }
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
