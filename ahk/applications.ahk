; # Win (Windows logo key)
; ! Alt
; ^ Control
; + Shift
; & An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.


#NoEnv
#Persistent
#SingleInstance, force
Process, Priority, %PID%, High
SetBatchLines, -1

SetWorkingDir, %A_ScriptDir%

$CapsLock::Ctrl 

#s:: Send {PrintScreen}

::zoomlink::https://hashicorp.zoom.us/j/9101845328?pwd=WXRFQ3VJWGdwQWdNRGhxZHAyRXJBUT09

; Application Shortcuts
!+t::
	Run, wt.exe
Return

!+c::
	Run, chrome.exe
Return

!e::
	Run, msedge.exe
Return

!^Backspace::
	ScriptPath := A_ScriptDir "\scripts\Random-Wallpaper.ps1"
	if (A_ComputerName = "Analog") {
		Run, PowerShell.exe -Command "%ScriptPath% -WallPaperPath C:\Users\eric\Pictures\Wallpaper\5120x1440", A_ScriptDir, Hide
	} else {
		Run, PowerShell.exe -Command "%ScriptPath% -WallPaperPath C:\Users\eric\Pictures\Wallpaper", A_ScriptDir, Hide
	}
Return
