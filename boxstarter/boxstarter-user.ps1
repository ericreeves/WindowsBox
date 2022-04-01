#-------------------------------------------------------------------------------
#--- Install Scoop Package Manager ---
#-------------------------------------------------------------------------------
Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression

#-------------------------------------------------------------------------------
#--- Install Scoop Apps ---
#-------------------------------------------------------------------------------
scoop bucket add extras
$ScoopApps = @(
    "komorebi",
    "touchcursor",
    "translucenttb",
    "roundedtb"
)

foreach ($app in $ScoopApps) {
    scoop install "$app"
}