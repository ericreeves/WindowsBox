# ----------------------------------------------------------------------------
# Configuration
# ----------------------------------------------------------------------------

$AHK_Folder = "C:\Users\eric\Rice\windowsbox\ahk"
$AHK_Filename = "ahk-init.ahk"
$Komorebi_Bin_Folder = "C:\Users\eric\.cargo\bin"
$Python_Bin_Folder = "C:\Users\eric\AppData\Local\Microsoft\WindowsApps"
$Yasb_Folder = "C:\Users\eric\Rice\yasb"

function Get-Process-Command
{
	param (
		[String] $Name
	)
	Get-WmiObject Win32_Process -Filter "name = '$Name.exe'" -ErrorAction SilentlyContinue | Select-Object CommandLine,ProcessId
}
function Wait-For-Process
{
    param
    (
		[String] $Name,
        [Switch] $IgnoreExistingProcesses
    )

    if ($IgnoreExistingProcesses)
    {
        $NumberOfProcesses = (Get-Process -Name $Name -ErrorAction SilentlyContinue).Count
    }
    else
    {
        $NumberOfProcesses = 0
    }

    Write-Host "--- Waiting for $Name" -NoNewline
    while ( (Get-Process -Name $Name -ErrorAction SilentlyContinue).Count -eq $NumberOfProcesses )
    {
        Write-Host '.' -NoNewline
        Start-Sleep -Milliseconds 400
    }

    Write-Host ''
}