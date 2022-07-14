; ---------------------------------------------------------------------------------
; Main Komorebi Configuration
; ---------------------------------------------------------------------------------
;
#SingleInstance force                     ; Force only a single instance running, so you don't get hotkey conflicts
#NoEnv                                    ; Recommended for performance and compatibility with future AutoHotkey releases.

; Komorebic Library
SetWorkingDir, %A_ScriptDir%
#Include %A_ScriptDir%\komorebic.lib.ahk

; Workspace Configuration
; #Include %A_ScriptDir%\komorebi.workspaces.ahk

; Generated Application Rules
#Include %A_ScriptDir%\komorebi.generated.ahk

; Keyboard Commands
; #Include %A_ScriptDir%\komorebi.keyboardshortcuts.ahk

; ---------------------------------------------------------------------------------
; Behavior Configuration
; ---------------------------------------------------------------------------------

; Set the resize delta - increase/decrease to adjust how much each resize command modifies
ResizeDelta(50)

; Configure the invisible border dimensions
InvisibleBorders(7, 0, 14, 7)

; Default to minimizing windows when switching workspaces
WindowHidingBehaviour("minimize")

; Enable hot reloading of changes to this file
WatchConfiguration("enable")

; Mouse follows focus
ToggleMouseFollowsFocus()

; ---------------------------------------------------------------------------------
; Workspace and Monitor Creation and Configuration
; ---------------------------------------------------------------------------------

; Workspace Padding
wPadding = 0

; Container Padding
cPadding = 0

; Default Workspace Layout
Layout = "bsp"

; Create 10 workspaces and set default tiling and padding
Monitors := [0, 1]
Desktops := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

; Configure Each Monitor
for i, Monitor in Monitors
{
	; Create 10 Workspaces
	EnsureWorkspaces(%Monitor%, 10)
	; Configure Each Workspace on Each Monitor
	for j, Desktop in Desktops
	{
		Run, komorebic.exe workspace-padding %Monitor% %Desktop% %wPadding%, , Hide
		Run, komorebic.exe container-padding %Monitor% %Desktop% %cPadding%, , Hide
		Run, komorebic.exe workspace-layout  %Monitor% %Desktop% %Layout%, , Hide
		Run, komorebic.exe workspace-tiling  %Monitor% %Desktop% enable, , Hide
	}
}

; ---------------------------------------------------------------------------------
; Workspace Configuration
; ---------------------------------------------------------------------------------
;
; Workspace naming and application pinning
;

; Workspace 1
WorkspaceName(0, 0, "Chat")
WorkspaceRule("exe", "Ferdium.exe", 0, 0) ; Always show chat apps on this workspace
; WorkspaceRule("exe", "WhatsApp.exe", 0, 0) 

; Workspace 2
WorkspaceName(0, 1, "Terminal")
WorkspaceRule("exe", "wt.exe", 0, 1) 
WorkspaceRule("exe", "alacritty.exe", 0, 1) 

; Workspace 3
WorkspaceName(0, 2, "Browser")
WorkspaceRule("exe", "chrome.exe", 0, 2) 
WorkspaceRule("exe", "msedge.exe", 0, 2) 

; Workspace 4
WorkspaceName(0, 3, "Editor")
WorkspaceRule("exe", "Code.exe", 0, 3) 

; Workspace 5
WorkspaceName(0, 4, "Phone")
; WorkspaceRule("title", "Your Phone", 0, 4) 

; Workspace 6
WorkspaceName(0, 5, "6")
; WorkspaceRule("exe", "Discord.exe", 0, 5) 

; Workspace 7
WorkspaceName(0, 6, "7")

; Workspace 8
WorkspaceName(0, 7, "Music")
; WorkspaceRule("exe", "Spotify.exe", 0, 7) 

; Workspace 9
WorkspaceName(0, 8, "9")

; Workspace 10
WorkspaceName(0, 9, "10")

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
Focus("right")
return

!h::
Focus("left")
return

!k::
Focus("up")
return

!j::
Focus("down")
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
!=::
Manage()
return

; Unmanage the focused window
; Alt + Shift + -
!-::
Unmanage()
return

; Toggle the Monocle layout for the focused window
; Alt + Shift + '
!'::
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
!c::
FlipLayout("horizontal")
return

; Flip vertically
; Alt + Shift + v
!v::
FlipLayout("vertical")
return

; Force a retile if things get janky
; Alt + Shift + R
!r::
Retile()
return

; Forcibly restart komorebi
; Ctrl + Alt + Shift + R
; !^+r::
; WinGet, WindowList, List,,, Program Manager
; Loop, %WindowList%
; {
;   WinGetClass, Class, % "ahk_id " . WindowList%A_Index%
;   IF (Class <> "Shell_SecondaryTrayWnd" And Class <> "Shell_TrayWnd")
;     WinMinimize, % "ahk_id " . WindowList%A_Index%
; }
; RunWait, pskill.exe -t komorebi.exe, ,Hide,
; RunWait, C:\Users\eric\scoop\shims\komorebic.exe start, ,Hide,
; return

; Float the focused window
; Alt + Shift + f
!f::
ToggleFloat()
return

; Toggle tiling on current workspace
; Alt + Shift + t
!t::
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
; Win + [12]
#2::
FocusMonitor(0)
return

#1::
FocusMonitor(1)
return

; Move window to monitor
; Win + Ctrl + [12]
#^2::
MoveToMonitor(0)
return

#^1::
MoveToMonitor(1)
return

    ; send-to-monitor-workspace
    ; focus-monitor-workspace

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

