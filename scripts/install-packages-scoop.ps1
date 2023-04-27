
#
# Scoop Packages to Install
#
$appsScoop = @(
    @{ name = "lsd" }
    @{ name = "terraform" }
    @{ name = "packer" }
    @{ name = "vault" }
    @{ name = "ripgrep" }
    @{ name = "vcredist2022" }
    @{ name = "fd" }
    @{ name = "sd" }
    @{ name = "dust" }
    @{ name = "dua" }
    @{ name = "gdu" }
    @{ name = "dog" }
    @{ name = "xh" }
    @{ name = "duf" }
    @{ name = "bat" }
    @{ name = "fzf" }
    @{ name = "tldr" }
    @{ name = "zig" }
#    @{ name = "exa" }
)

#-------------------------------------------------------------------------------
#--- Scoop Apps ---
#-------------------------------------------------------------------------------
Foreach ($app in $appsScoop) {
    Write-host "Installing:" $app.name
    scoop install $app.name
}
