;
; Komorebi Monitor, Workspace, and Application Rules
;

; Komorebic Library
SetWorkingDir, %A_ScriptDir%
#Include %A_ScriptDir%\include\komorebic.lib.ahk

; ---------------------------------------------------------------------------------
; Monitor Configuration
; ---------------------------------------------------------------------------------

; Create 10 workspaces on 2 monitors
EnsureWorkspaces(0, 10)
EnsureWorkspaces(1, 10)

; ---------------------------------------------------------------------------------
; Workspace Creation and Configuration
; ---------------------------------------------------------------------------------

; Workspace Padding
wPadding = 10

; Container Padding
cPadding = 10

; Workspace Layout
Layout = "bsp"

; Create 10 workspaces and set default tiling and padding
Desktops := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
for k, v in Desktops
{
	Run, komorebic.exe workspace-padding 0 %v% %wPadding%, , Hide
	Run, komorebic.exe container-padding 0 %v% %cPadding%, , Hide
	Run, komorebic.exe workspace-layout 0 %v% %v%, , Hide
	Run, komorebic.exe workspace-tiling 0 %v% %Layout%, , Hide
	Run, komorebic.exe workspace-padding 1 %v% %wPadding%, , Hide
	Run, komorebic.exe container-padding 1 %v% %cPadding%, , Hide
	Run, komorebic.exe workspace-layout 1 %v% %v%, , Hide
	Run, komorebic.exe workspace-tiling 1 %v% %Layout%, , Hide
}

; ---------------------------------------------------------------------------------
; Workspace Configuration
; ---------------------------------------------------------------------------------
;
; Workspace naming and application pinning
;

; Workspace 1
WorkspaceName(0, 0, "Chat")
WorkspaceRule("exe", "Ferdi.exe", 0, 0) ; Always show chat apps on this workspace
WorkspaceRule("exe", "WhatsApp.exe", 0, 0) 

; Workspace 2
WorkspaceName(0, 1, "Terminal")
WorkspaceRule("exe", "wt.exe", 0, 1) 
WorkspaceRule("exe", "alacritty.exe", 0, 1) 

; Workspace 3
WorkspaceName(0, 2, "Browser")
WorkspaceRule("exe", "firefox.exe", 0, 2) 
WorkspaceRule("exe", "msedge.exe", 0, 2) 

; Workspace 4
WorkspaceName(0, 3, "Editor")
WorkspaceRule("exe", "Code.exe", 0, 3) 

; Workspace 5
WorkspaceName(0, 4, "Phone")
WorkspaceRule("title", "Your Phone", 0, 4) 

; Workspace 6
WorkspaceName(0, 5, "Social")
WorkspaceRule("exe", "Discord.exe", 0, 5) 

; Workspace 7
WorkspaceName(0, 6, "Workspace 7")

; Workspace 8
WorkspaceName(0, 7, "Music")
WorkspaceRule("exe", "Spotify.exe", 0, 7) 

; Workspace 9
WorkspaceName(0, 8, "Workspace 9")

; Workspace 10
WorkspaceName(0, 9, "Workspace 10")
