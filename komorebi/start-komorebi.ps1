komorebic start
Start-Sleep -Milliseconds 1000
C:\Users\eric\.config\komorebi\komorebi.ahk
Start-Sleep -Milliseconds 1000

if (((Get-WmiObject WmiMonitorID -namespace root\wmi).InstanceName) -like "*VTK*") {
   komorebic workspace-layout 0 0 columns
}