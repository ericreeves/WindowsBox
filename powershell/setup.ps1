Install-Module VirtualDesktop
Install-Module -Name Terminal-Icons -Repository PSGallery
# Install-Module PoshColor

Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted       

winget install gsudo
winget install oh-my-posh
winget install lsd

gh api '/repos/ryanoasis/nerd-fonts/releases/latest' -q '.assets[]|.name' | ForEach-Object { gsudo oh-my-posh font install $_.TrimEnd('.zip') }