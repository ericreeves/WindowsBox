gh api '/repos/ryanoasis/nerd-fonts/releases/latest' -q '.assets[]|.name' | ForEach-Object { gsudo oh-my-posh font install $_.TrimEnd('.zip') }
