#-------------------------------------------------------------------------------
#--- Install Scoop Package Manager ---
#-------------------------------------------------------------------------------
#Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression

#-------------------------------------------------------------------------------
#--- Install Scoop Apps ---
#-------------------------------------------------------------------------------
$ScoopApps = @(
    "glazewm"
    # # "touchcursor",
    # # "translucenttb",
    # # "roundedtb",
    # # "1password",
    # # "googlechrome",
    # "chezmoi",
    # # "vscode",
    # "alacritty",
    # "github-desktop",
    # "nvidia-geforce-now",
    # "tailscale",
    # "synctrayzor",
    # "signal",
    # # "obs-studio",
    # # "obs-virtualcam",
    # "winaero-tweaker",
    # "mpvnet",
    # "keybase",
    # "autohotkey",
    # "vlc",
    # "sysinternals",
    # "hwinfo",
    # "nuget.commandline",
    # "NugetPackagdExplorer",
    # "filezilla",
    # "paint.net",
    # #"mousewithoutborders",
    # "pingplotter",
    # # "eartrumpet",
    # "windirstat",
    # "spotify",
    # # "joplin",
    # # "puretext",
    # "quickview",
    # "powertoys",
    # "discord",
    # "betterdiscord",
    # "sudo",
    # # "rustup.install",
    # # "just",
    # "irfanview"
)

scoop bucket add extras
scoop bucket add scoop-littleli https://github.com/littleli/Scoop-littleli.git
scoop update

foreach ($app in $ScoopApps) {
    scoop install "$app"
    scoop update "$app"
}