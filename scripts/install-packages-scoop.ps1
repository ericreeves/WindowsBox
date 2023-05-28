
#
# Scoop Packages to Install
#
$appsScoop = @(
    @{ name = "lsd" }
    @{ name = "terraform" }
    @{ name = "packer" }
    @{ name = "vault" }
    @{ name = "ripgrep" }
    # @{ name = "vcredist2022" }
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
    @{ name = "winfetch" }
    @{ name = "lf" }
    @{ name = "bottom" }
    @{ name = "lazygit" }
    @{ name = "btop" }
    @{ name = "make" }
    # @{ name = "rust" }
    @{ name = "python" }
    @{ name = "komorebi" }
    @{ name = "whkd" }
    @{ name = "autohotkey" }
    @{ name = "ffmpeg" }
    @{ name = "stylua" }
    @{ name = "winaero-tweaker" }
    @{ name = "whatinstartup" }
    @{ name = "shellexview" }
    @{ name = "topgrade" }
    @{ name = "zoxide" }
    @{ name = "scoop-search" }
    @{ name = "nvcleanstall" }
#    @{ name = "exa" }
)

#-------------------------------------------------------------------------------
#--- Scoop Apps ---
#-------------------------------------------------------------------------------
Foreach ($app in $appsScoop) {
    Write-host "Installing:" $app.name
    scoop install $app.name
}
