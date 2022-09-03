; # Win (Windows logo key)
; ! Alt
; ^ Control
; + Shift
; & An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.

SetWorkingDir, %A_ScriptDir%

::zoomlink::https://hashicorp.zoom.us/j/9101845328?pwd=WXRFQ3VJWGdwQWdNRGhxZHAyRXJBUT09

$CapsLock::Ctrl 

#s:: Send {PrintScreen}

#^l::WinSet, Bottom,, % "ahk_id " wins().1
#^k::
wins := wins()
WinActivate, % "ahk_id " wins[wins.Count()]
Return

wins() {
 uid := []
 WinGet, wins, List
 Loop, %wins% {
  WinGet, style, Style, % "ahk_id " wins%A_Index%
  If !(style ~= "0x(9|16)")
   uid.Push(wins%A_Index%)
 }
 Return uid
}

!`:: ;
WinGetClass, CurrentActive, A
WinGet, Instances, Count, ahk_class %CurrentActive%
If Instances > 1
    WinSet, Bottom,, A
WinActivate, ahk_class %CurrentActive%
return

!m::
Send, {F11}
return

; Alt-W and Alt-Q Close Windows
!^w:: WinClose A
!^q:: Send !{F4}

; Application Shortcuts
; !t::
; 	Run, "C:\Program Files\Alacritty\alacritty.exe"
; Return

; Application Shortcuts
!t::
	Run, alacritty.exe
Return

!b::
	Run, chrome.exe
Return

;^!w::
; !+t::
; 	Run, wt.exe
; Return

; !b::
; 	Run, msedge.exe
; Return

!^r::
	ScriptPath := A_ScriptDir "\scripts\Random-Wallpaper.ps1"
	Run, PowerShell.exe -Command "%ScriptPath% -WallPaperPath C:\Users\eric\Pictures\Wallpaper", A_ScriptDir, Hide
Return

; Reload this script 
; Ctrl + Alt + r
!r::
	Reload
Return


; Minimize All Windows
!+m::
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