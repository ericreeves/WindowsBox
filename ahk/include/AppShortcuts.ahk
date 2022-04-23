SetWorkingDir, %A_ScriptDir%

!m::
Send, {F11}
return

; Alt-W and Alt-Q Close Windows
!w:: WinClose A
!q:: Send !{F4}

; Application Shortcuts
!t::
	Run, "C:\Program Files\Alacritty\alacritty.exe"
Return

; Application Shortcuts
!g::
	Run, wt.exe
Return

!b::
	Run, msedge.exe
Return

!r::
	ScriptPath := A_ScriptDir "\scripts\Random-Wallpaper.ps1"
	Run, PowerShell.exe -Command "%ScriptPath% -WallPaperPath C:\Users\eric\Pictures\Wallpaper\5120x1440", A_ScriptDir, Hide
Return

; Reload this script 
; Ctrl + Alt + r
^!r::
	Reload
Return


; Minimize All Windows
^!m::
	WinGet, WindowList, List,,, Program Manager
	Loop, %WindowList%
	{
		WinGetClass, Class, % "ahk_id " . WindowList%A_Index%
		IF (Class <> "Shell_SecondaryTrayWnd" And Class <> "Shell_TrayWnd")
			WinMinimize, % "ahk_id " . WindowList%A_Index%
	}
Return

; In Elecom MouseAssistant: 
;   - bind your "toggle track scroll" button to RAlt
;   - bind your "middle click" button to RCtrl
; Bind RAlt and RCtrl to XButton1/XButton2 for TrackBallScroll.exe
RAlt::XButton1
RCtrl::XButton2