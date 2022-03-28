; #SingleInstance force                     ; Force only a single instance running, so you don't get hotkey conflicts
; #NoEnv                                    ; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir, %A_ScriptDir%

; Include %A_ScriptDir%\capslock.ahk

; Komorebic Library
#Include %A_ScriptDir%\include\komorebic.lib.ahk

; Workspace Padding
wPadding = 10

; Container Padding
cPadding = 10

Desktops := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
for k, v in Desktops
{
  Run, komorebic.exe workspace-padding 0 %v% %wPadding%, , Hide
  Run, komorebic.exe container-padding 0 %v% %cPadding%, , Hide
  Run, komorebic.exe workspace-layout 0 %v% %v%, , Hide
  Run, komorebic.exe workspace-tiling 0 %v% "bsp", , Hide
  Run, komorebic.exe workspace-padding 1 %v% %wPadding%, , Hide
  Run, komorebic.exe container-padding 1 %v% %cPadding%, , Hide
  Run, komorebic.exe workspace-layout 1 %v% %v%, , Hide
  Run, komorebic.exe workspace-tiling 1 %v% "bsp", , Hide
}

; ! Alt
; # Win
; ^ Ctrl
; + Shift

; Default to minimizing windows when switching workspaces
WindowHidingBehaviour("minimize")
; WindowHidingBehaviour("hide")

; Enable hot reloading of changes to this file
WatchConfiguration("enable")

; Mouse follows focus
ToggleMouseFollowsFocus()
; FocusFollowsMouse("enable", "windows")

; Ensure there are 5 workspaces created on monitor 0
EnsureWorkspaces(0, 10)
EnsureWorkspaces(1, 10)

; Configure the invisible border dimensions
InvisibleBorders(7, 0, 14, 7)

; Set the resize delta
ResizeDelta(50)

; Resize the focused window, Alt + Ctrl + Vim direction keys
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


; Configure the 1st workspace
WorkspaceName(0, 0, "Chat")
WorkspaceRule("exe", "Ferdi.exe", 0, 0) ; Always show chat apps on this workspace

; Configure the 2nd workspace
WorkspaceName(0, 1, "Terminal")
; WorkspaceName(0, 1, "columns") ; Optionally set the name of the workspace
; WorkspacePadding(0, 1, 30) ; Set the padding around the edge of the screen
; ContainerPadding(0, 1, 30) ; Set the padding between the containers on the screen
WorkspaceRule("exe", "wt.exe", 0, 1) 

; Configure the 3rd workspace
WorkspaceName(0, 2, "Browser")
WorkspaceRule("exe", "firefox.exe", 0, 2) 
; WorkspacePadding(0, 2, 200) ; Set some super thicc padding

; Configure the 4th workspace
WorkspaceName(0, 3, "Editor")
WorkspaceRule("exe", "Code.exe", 0, 3) 

; Configure the 5th workspace
;WorkspaceName(0, 4, "y")
; WorkspaceTiling(0, 4, "disable") ; Everything floats here

; Configure the 6th workspace
WorkspaceRule("exe", "Discord.exe", 0, 5) 

; Configure the 7th workspace
WorkspaceRule("exe", "Signal.exe", 0, 6) 

; Configure the 8th workspace

; Configure the 9th workspace

; Configure the 10th workspace

; Configure floating rules
FloatRule("class", "SunAwtDialog") ; All the IntelliJ popups
FloatRule("title", "Control Panel")
FloatRule("class", "TaskManagerWindow")
FloatRule("class", "MsiDialogCloseClass")
FloatRule("exe", "KensingtonWorks2.exe")
; FloatRule("exe", "msiexec.exe")
FloatRule("exe", "Wally.exe")
FloatRule("exe", "wincompose.exe")
FloatRule("exe", "1Password.exe")
FloatRule("exe", "Wox.exe")
; FloatRule("exe", "ddm.exe")
; FloatRule("exe", "Zoom.exe")
FloatRule("exe", "QuickLook.exe")
FloatRule("exe", "ApplicationFrameHost.exe")
FloatRule("class", "Chrome_RenderWidgetHostHWND") ; GOG Electron invisible overlay
FloatRule("class", "CEFCLIENT")
FloatRule("class", "ZPPTMainFrmWndClassEx")
FloatRule("class", "ZPContentViewWndClass")


; Identify Minimize-to-Tray Applications
IdentifyTrayApplication("exe", "Discord.exe")
IdentifyTrayApplication("exe", "Ferdi.exe")
IdentifyTrayApplication("exe", "Spotify.exe")
IdentifyTrayApplication("exe", "GalaxyClient.exe")
IdentifyTrayApplication("exe", "Zoom.exe")
IdentifyTrayApplication("exe", "QuickLook.exe")
IdentifyTrayApplication("exe", "KensingtonWorks2.exe")
IdentifyTrayApplication("class", "ZPPTMainFrmWndClassEx")
IdentifyTrayApplication("class", "ZPContentViewWndClass")

; Identify Electron applications with overflowing borders
IdentifyBorderOverflow("exe", "Discord.exe")
IdentifyBorderOverflow("exe", "Ferdi.exe")
IdentifyBorderOverflow("exe", "Spotify.exe")
IdentifyBorderOverflow("exe", "GalaxyClient.exe")
IdentifyBorderOverflow("class", "ZPFTEWndClass")
IdentifyBorderOverflow("exe", "Zoom.exe")
IdentifyBorderOverflow("class", "ZPPTMainFrmWndClassEx")
IdentifyBorderOverflow("class", "ZPContentViewWndClass")
IdentifyBorderOverflow("exe", "KensingtonWorks2.exe")
IdentifyBorderOverflow("exe", "Tabby.exe")
IdentifyBorderOverflow("exe", "ApplicationFrameHost.exe")

; Identify applications to be forcibly managed
ManageRule("exe", "GalaxyClient.exe")
ManageRule("exe", "Ferdi.exe")
ManageRule("exe", "Tabby.exe")

!.::
FocusMonitor(0)
return

!,::
FocusMonitor(1)
return

!^.::
MoveToMonitor(0)
return

!^,::
MoveToMonitor(1)
return



; Change the focused window, Alt + Vim direction keys
!h::
Focus("left")
return

!j::
Focus("down")
return

!k::
Focus("up")
return

!l::
Focus("right")
return

; Move the focused window in a given direction, Alt + Shift + Vim direction keys
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

; Stack the focused window in a given direction, Alt + Shift + direction keys
!#h::
Stack("left")
return

!#j::
Stack("down")
return

!#k::
Stack("up")
return

!#l::
Stack("right")
return

!#o::
CycleStack("next")
return

!#i::
CycleStack("previous")
return

; Unstack the focused window, Alt + Win + D
!#d::
Unstack()
return

; Promote the focused window to the top of the tree, Alt + Shift + Enter
!+'::
Promote()
return

; Manage the focused window
!+=::
Manage()
return

; Unmanage the focused window
!+-::
Unmanage()
return

; Layout: vertical-stack, Alt + Shift + 
; !+v::
; ChangeLayout("vertical-stack")
; return

; Layout: horizontal-stack, Alt + Shift + 
; Switch to the default bsp tiling layout on the main workspace, Alt + Shift + T
; !+c::
; ChangeLayout("bsp")
; return

; Toggle the Monocle layout for the focused window, Alt + Shift + F
!+m::
ToggleMonocle()
return

; Toggle native maximize for the focused window, Alt + Shift + m
!+Enter::
ToggleMaximize()
return

; Flip horizontally, Alt + X
!+c::
FlipLayout("horizontal")
return

; Flip vertically, Alt + Y
!+v::
FlipLayout("vertical")
return

; Force a retile if things get janky, Alt + Shift + R
!+r::
Retile()
return

; Forcibly restart komorebi, Ctrl + Alt + Shift + R
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

; Float the focused window, Alt + T
!+f::
ToggleFloat()
return

; Toggle tiling on current workspace
!+t::
ToggleTiling()
return


; Reload ~/komorebi.ahk, Alt + O
!o::
ReloadConfiguration()
return

; Pause responding to any window events or komorebic commands, Alt + P
!p::
TogglePause()
return

!m::
ToggleMouseFollowsFocus()
return

; Switch to workspace
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
