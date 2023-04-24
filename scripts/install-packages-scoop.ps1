
#
# Scoop Packages to Install
#
$appsScoop = @(
    @{ name = "lsd" }
    @{ name = "terraform" }
    @{ name = "packer" }
    @{ name = "vault" }
)

#-------------------------------------------------------------------------------
#--- Scoop Apps ---
#-------------------------------------------------------------------------------
Foreach ($app in $appsScoop) {
    Write-host "Installing:" $app.name
    scoop install $app.name
}
