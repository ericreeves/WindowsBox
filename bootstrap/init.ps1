#
# HOWTO Run This
#
# From an admin@Powershell
#
# Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://gist.githubusercontent.com/ericreeves/4b9e577539e4e85265604ff48bb19d05/raw/096d40750965321a021e7fcc36f9a75a10093333/init.ps1'))
#

#
# Install Chocolatey
#
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

# . { iwr -useb http://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
# install-boxstarterpackage -PackgeName <GIST URL>

Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n=allowGlobalConfirmation
choco feature enable -n=useRememberedArgumentsForUpgrades
choco install boxstarter
choco install boxstarter.bootstrapper

#
# Run boxstarter-admin
#
Install-BoxstarterPackage -PackageName https://gist.githubusercontent.com/ericreeves/4b9e577539e4e85265604ff48bb19d05/raw/e7a293bcdb3472020ec77a6160fd082c94c27289/boxstarter-admin.ps1

#
# Run boxstarter-user
#
$Cred = Get-Credential coldfire\eric
Install-BoxstarterPackage -PackageName  https://gist.githubusercontent.com/ericreeves/4b9e577539e4e85265604ff48bb19d05/raw/753ccc407985083f3050215cc846ddb8a014a1ee/boxstarter-user.ps1 -Credential $cred