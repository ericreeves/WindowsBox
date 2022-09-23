#-------------------------------------------------------------------------------
#--- Install Scoop Package Manager ---
#-------------------------------------------------------------------------------
#Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression

#-------------------------------------------------------------------------------
#--- Install Scoop Apps ---
#-------------------------------------------------------------------------------
scoop bucket add extras
$ScoopApps = @(
    "komorebi",
    "touchcursor",
    "translucenttb",
    "roundedtb",
    "1password",
    "googlechrome",
    "chezmoi",
    "vscode",
    "alacritty",
    "7zip",
    "github-desktop",
    "nvidia-geforce-now",
    "tailscale",
    "synctrayzor",
    "signal",
    # "obs-studio",
    # "obs-virtualcam",
    "winaero-tweaker",
    "mpvnet",
    "keybase",
    "autohotkey",
    "vlc",
    "sysinternals",
    "hwinfo",
    "nuget.commandline",
    "NugetPackageExplorer",
    "filezilla",
    "paint.net",
    #"mousewithoutborders",
    "pingplotter",
    # "eartrumpet",
    "windirstat",
    "spotify",
    # "joplin",
    # "puretext",
    "quickview",
    "powertoys",
    "discord",
    "betterdiscord",
    "sudo",
    # "rustup.install",
    # "just",
    "irfanview"
)

foreach ($app in $ScoopApps) {
    scoop install "$app"
}