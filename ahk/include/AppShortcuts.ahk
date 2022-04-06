SetWorkingDir, %A_ScriptDir%

; Escape Closes Things!
; $Escape::                                               ; Long press (> 0.5 sec) on Esc closes window
;     KeyWait, Escape, T0.5                               ; Wait no more than 0.5 sec for key release (also suppress auto-repeat)
;     If ErrorLevel                                       ; timeout, so long press
;         PostMessage, 0x112, 0xF060,,, A                 ; ...close window
;     Else                                                ; otherwise...
;         Send {Esc}                                       ; ...just send Escape
; Return

; Alt-W and Alt-Q Close Windows
!w:: WinClose A
!q:: Send !{F4}

; Application Shortcuts
!t::
	Run, "C:\Program Files\Alacritty\alacritty.exe"
Return

; Application Shortcuts
#t::
	Run, wt.exe
Return

!b::
	Run, msedge.exe
Return

; Open komorebi log viewer window
!#^l::
	Run, alacritty.exe -o window.opacity=0.8 -o font.size=8 -t "Komorebi Logs" -e komorebic.exe log
Return

!r::
	ScriptPath := A_ScriptDir "\scripts\RandomWallpaper.ps1"
	Run, PowerShell.exe -Command "%ScriptPath% -WallPaperPath C:\Users\eric\Pictures\Wallpaper", A_ScriptDir, Hide
return

; Reload this script 
; Ctrl + Win + Alt + r
^#!r::
	Reload
Return

; Force-Restart Komorebi and AHK
^#!x::
	ScriptPath := A_ScriptDir "\scripts\Force-Restart-Komorebi.ps1"
	Run, PowerShell.exe -Command "%ScriptPath%", A_ScriptDir, Hide
Return

; In Elecom MouseAssistant: 
;   - bind your "toggle track scroll" button to RAlt
;   - bind your "middle click" button to RCtrl
; Bind RAlt and RCtrl to XButton1/XButton2 for TrackBallScroll.exe
RAlt::XButton1
RCtrl::XButton2