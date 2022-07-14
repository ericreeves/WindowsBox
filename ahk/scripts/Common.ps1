# ----------------------------------------------------------------------------
# Configuration
# ----------------------------------------------------------------------------

$AHK_Folder = "C:\Users\Eric Reeves\Config\WindowsBox\ahk"
$AHK_Filename = "komorebi.ahk"
$Komorebi_Bin_Folder = "C:\Users\Eric Reeves\Bin"
$Python_Bin_Folder = "C:\Users\Eric Reeves\AppData\Local\Programs\Python\Python39"
$Yasb_Folder = "C:\Users\Eric Reeves\Config\WindowsBox\yasb"

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