; ---------------------------------------------------------------------------------
; Keyboard Commands
; ---------------------------------------------------------------------------------
;
; AHK Modifier Key Symbols
;
; ! Alt
; # Win
; ^ Ctrl
; + Shift
;

; Komorebic Library
SetWorkingDir, %A_ScriptDir%
#Include %A_ScriptDir%\include\komorebic.lib.ahk

; Resize the focused window
; Alt + Ctrl + <vim directional keys>
!^h::
ResizeAxis("horizontal", "decrease")
return

!^j::
ResizeAxis("vertical", "decrease")
return

!^k::
ResizeAxis("vertical", "increase")
return

!^l::
ResizeAxis("horizontal", "increase")
return


; Cycle Focus and Resize, DWM-style
!l::
CycleFocus("next")
return

!h::
CycleFocus("previous")
return

!k::
ResizeAxis("horizontal-and-vertical", "increase")
return

!j::
ResizeAxis("horizontal-and-vertical", "decrease")
return

; Alt + Shift + <vimkeys> - Move the focused window in a given direction
!+h::
Move("left")
return

!+j::
Move("down")
return

!+k::
Move("up")
return

!+l::
Move("right")
return

; Alt + Enter - Promote the focused window to the top of the tree
!Enter::
Promote()
return

; Manage the focused window
; Alt + Shift + =
!+=::
Manage()
return

; Unmanage the focused window
; Alt + Shift + -
!+-::
Unmanage()
return

; Toggle the Monocle layout for the focused window
; Alt + Shift + '
!+'::
ToggleMonocle()
return

; Toggle native maximize for the focused window
; Alt + Shift + Enter
!+Enter::
ToggleMaximize()
return

; Native fullscreen (F11)
; Alt + Shift + m
!+m::
Send, {F11}
return

; Flip horizontally
; Alt + Shift + c
!+c::
FlipLayout("horizontal")
return

; Flip vertically
; Alt + Shift + v
!+v::
FlipLayout("vertical")
return

; Force a retile if things get janky
; Alt + Shift + R
!+r::
Retile()
return

; Forcibly restart komorebi
; Ctrl + Alt + Shift + R
!^+r::
WinGet, WindowList, List,,, Program Manager
Loop, %WindowList%
{
  WinGetClass, Class, % "ahk_id " . WindowList%A_Index%
  IF (Class <> "Shell_SecondaryTrayWnd" And Class <> "Shell_TrayWnd")
    WinMinimize, % "ahk_id " . WindowList%A_Index%
}
RunWait, pskill.exe -t komorebi.exe, ,Hide,
RunWait, C:\Users\eric\scoop\shims\komorebic.exe start, ,Hide,
return

; Float the focused window
; Alt + Shift + f
!+f::
ToggleFloat()
return

; Toggle tiling on current workspace
; Alt + Shift + t
!+t::
ToggleTiling()
return


; Reload ~/komorebi.ahk
; Alt + Shift + o
!+o::
ReloadConfiguration()
return

; Pause responding to any window events or komorebic commands
; Alt + Shift + p
!p::
TogglePause()
return

; Switch to monitor
; Alt + [,.]
!.::
FocusMonitor(0)
return

!,::
FocusMonitor(1)
return

; Move window to monitor
; Alt + Ctrl + [,.]
!^.::
MoveToMonitor(0)
return

!^,::
MoveToMonitor(1)
return

; Switch to workspace
; Alt + #
!1::
Send !
FocusWorkspace(0)
return

!2::
Send !
FocusWorkspace(1)
return

!3::
Send !
FocusWorkspace(2)
return

!4::
Send !
FocusWorkspace(3)
return

!5::
Send !
FocusWorkspace(4)
return

!6::
Send !
FocusWorkspace(5)
return

!7::
Send !
FocusWorkspace(6)
return

!8::
Send !
FocusWorkspace(7)
return

!9::
Send !
FocusWorkspace(8)
return

!0::
Send !
FocusWorkspace(9)
return


; Move window to workspace 
; Alt + Ctrl + #
!^1::
MoveToWorkspace(0)
return

!^2::
MoveToWorkspace(1)
return

!^3::
MoveToWorkspace(2)
return

!^4::
MoveToWorkspace(3)
return

!^5::
MoveToWorkspace(4)
return

!^6::
MoveToWorkspace(5)
return

!^7::
MoveToWorkspace(6)
return

!^8::
MoveToWorkspace(7)
return

!^9::
MoveToWorkspace(8)
return

!^0::
MoveToWorkspace(9)
return
