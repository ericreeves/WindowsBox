
function InstallScoop()
{
        irm get.scoop.sh | iex
	scoop bucket add extras
}

function InstallWinget()
{
        # get latest download url
        $URL = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
        $URL = (Invoke-WebRequest -Uri $URL).Content | ConvertFrom-Json |
                Select-Object -ExpandProperty "assets" |
                Where-Object "browser_download_url" -Match '.msixbundle' |
                Select-Object -ExpandProperty "browser_download_url"

        # download
        Invoke-WebRequest -Uri $URL -OutFile "Setup.msix" -UseBasicParsing

        # install
        Add-AppxPackage -Path "Setup.msix"

        # delete file
        Remove-Item "Setup.msix"
}


Write-Host "--- Setting Powershell ExecutionPolicy to Unrestricted."
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted

# Install scoop if needed
if (-not(Get-Command scoop)) {
        try {
                Write-Host "--- Installing scoop."
                InstallScoop
        }
        catch {
                throw $_.Exception.Message
        }
}
else {
        Write-Host "--- scoop already installed."
}

# Install winget-cli if needed
if (-not(Get-Command winget)) {
        try {
                Write-Host "--- Installing winget-cli."
                InstallWinget
        }
        catch {
                throw $_.Exception.Message
        }
}
else {
        Write-Host "--- winget-cli already installed."
}
