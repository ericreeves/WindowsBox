Install-Module VirtualDesktop -Scope CurrentUser
Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser
Install-Module posh-git -Scope CurrentUser
Install-Module Watch -Scope CurrentUser
Install-Module WingetTools -Scope CurrentUser
Install-Module HackF5.ProfileAlias -Scope CurrentUser
# Register-ProfileAliasInProfile



Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted       

#winget install gsudo
#winget install oh-my-posh
#winget install lsd

#gh api '/repos/ryanoasis/nerd-fonts/releases/latest' -q '.assets[]|.name' | ForEach-Object { gsudo oh-my-posh font install $_.TrimEnd('.zip') }
