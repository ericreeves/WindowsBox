; # Win (Windows logo key)
; ! Alt
; ^ Control
; + Shift
; & An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.
;
; https://www.autohotkey.com/docs/v1/KeyList.htm
;


; REMOVED: #NoEnv
Persistent
#SingleInstance force
ProcessSetPriority("High", PID)
; REMOVED: SetBatchLines, -1

SetWorkingDir(A_ScriptDir)

; $CapsLock::Ctrl 

#s::Send("{PrintScreen}")

::zoomlink::https://hashicorp.zoom.us/j/9101845328?pwd=WXRFQ3VJWGdwQWdNRGhxZHAyRXJBUT09

!m::WinMinimize("A")

!f::
{ ; V1toV2: Added bracket
Send("{F11}")
return

; Alt-W and Alt-Q Close Windows
} ; V1toV2: Added Bracket before hotkey or Hotstring
!w::WinClose("A")
!q::Send("!{F4}")

; Application Shortcuts
!+Enter::
{ ; V1toV2: Added bracket
	Run("wezterm-gui.exe")
Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

!+c::
{ ; V1toV2: Added bracket
	Run("chrome.exe")
Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

!+e::
{ ; V1toV2: Added bracket
	Run("msedge.exe")
Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

!+Backspace::
{ ; V1toV2: Added bracket
	ScriptPath := A_ScriptDir "\scripts\Random-Wallpaper.ps1"
	if (A_ComputerName = "Analog") {
		Run("PowerShell.exe -Command `"" ScriptPath " -WallPaperPath C:\Users\eric\Pictures\Wallpaper\5120x1440`"", "A_ScriptDir", "Hide")
	} else {
		Run("PowerShell.exe -Command `"" ScriptPath " -WallPaperPath C:\Users\eric\Pictures\Wallpaper`"", "A_ScriptDir", "Hide")
	}
Return

;^XButton1::
;    Send, ^w
;return
;return

;^XButton2::
;    Send, ^w
;return
;return
} ; V1toV2: Added Bracket before hotkey or Hotstring


^+WheelDown::
{ ; V1toV2: Added bracket
   Send("{Left}")
return
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

^+WheelUp::
{ ; V1toV2: Added bracket
   Send("{Right}")
return
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

^+MButton::
{ ; V1toV2: Added bracket
   Send("^w")
return
return

; +WheelDown::
;    Send, ^{PgUp}
; return
; return

; +WheelUp::
;    Send, ^{PgDn}
; return
; return

; +LButton::
;    Send, {Browser_Back}
; return
; return

; +RButton::
;    Send, {Browser_Forward}
; return
; return


; These macros trigger when Autohotkey detects the Elecom MouseAssist program sending the Japanese keys.
; https://www.reddit.com/r/Trackballs/comments/3zrl8h/elecom_driver_autohotkey_trick/

; 'Convert' Key
; Elecom Button 8 - Track Scroll
; vk1C::WheelLeft

; 'No Convert' Key
; Elecom Buttom 1 - Middle Click
; vk1D::XButton1

; ; Map the Japanese keys to F1-F4 so that you can enter them in the Elecom MouseAssist program.
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

} ; V1toV2: Added bracket in the end
