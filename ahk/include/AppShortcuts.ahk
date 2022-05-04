; # Win (Windows logo key)
; ! Alt
; ^ Control
; + Shift
; & An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.

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
!+t::
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
; RAlt::XButton1
; RCtrl::XButton2


; Map the Japanese keys to F1-F4 so that you can enter them in the Elecom MouseAssist program.

; F1::
; {
; Send {vk1C} ; Convert
; return
; }

; F2::
; {
; Send {vk1D} ; No Conversion
; return
; }

; F3::
; {
; Send {vk19} ; Half-width/Full-width
; return
; }

; F4::
; {
; Send {vk15} ; Katakana/Hiragana
; return
; }

; These macros trigger when Autohotkey detects the Elecom MouseAssist program sending the Japanese keys.

; 'Convert' Key
; Elecom Button 8 - Track Scroll
vk1C::XButton2

; 'No Convert' Key
; Elecom Buttom 1 - Middle Click
vk1D::XButton1

; vk19::
; {
; ToolTip, Half-width/Full-width
; return
; }

; vk15::
; {
; ToolTip, Katakana/Hiragana
; return
; }