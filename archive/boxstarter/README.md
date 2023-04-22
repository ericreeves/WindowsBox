# Windows 10/11 Workstation Setup

These are the scripts I use for bootstrapping and configuring my Windows workstation.

There are things you'll need to modify if you wish to make it work for you.  Maybe one day I'll try to make it more flexible.

## One-Shot Install Command

Open Windows Powershell as Admin

```powershell
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ericreeves/WindowsBox/master/boxstarter/init.ps1'))
```
