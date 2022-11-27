#-------------------------------------------------------------------------------
#--- Install Scoop Package Manager ---
#-------------------------------------------------------------------------------
#Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression

#-------------------------------------------------------------------------------
#--- Install Scoop Apps ---
#-------------------------------------------------------------------------------
$ScoopApps = @(
    "winlister"
)

scoop bucket add extras
scoop bucket add nirsoft
# scoop bucket add scoop-eric https://github.com/ericreeves/WindowsBox.git
scoop update

foreach ($app in $ScoopApps) {
    scoop install "$app"
    scoop update "$app"
}