;
; ---------------------------------------------------------------------------------
; Komorebi Application Rules
; ---------------------------------------------------------------------------------
; (Workarounds for Misbehaving Applications)
; ---------------------------------------------------------------------------------
;

; Komorebic Library
SetWorkingDir, %A_ScriptDir%
#Include %A_ScriptDir%\include\komorebic.lib.ahk

; Configure floating rules
FloatRule("class", "SunAwtDialog") ; All the IntelliJ popups
FloatRule("title", "Control Panel")
FloatRule("class", "TaskManagerWindow") ; Windows Task Manager
FloatRule("exe", "KensingtonWorks2.exe")
FloatRule("exe", "Wally.exe")
FloatRule("exe", "wincompose.exe")
FloatRule("exe", "1Password.exe")
FloatRule("exe", "Wox.exe")
FloatRule("exe", "QuickLook.exe")
FloatRule("exe", "RoundedTB.exe")
FloatRule("title", "Calculator")
FloatRule("title", "Call") ; Your Phone Call Window
FloatRule("title", "Window Spy") ; AHK Window Spy
FloatRule("class", "Chrome_RenderWidgetHostHWND") ; GOG Electron invisible overlay

; MS Office Fixes
FloatRule("class", "_WwB")
IdentifyBorderOverflow("exe", "WINWORD.EXE")
IdentifyLayeredApplication("exe", "WINWORD.EXE")

; Identify Minimize-to-Tray Applications
IdentifyTrayApplication("exe", "Discord.exe")
IdentifyTrayApplication("exe", "Ferdi.exe")
IdentifyTrayApplication("exe", "Spotify.exe")
IdentifyTrayApplication("exe", "GalaxyClient.exe")
IdentifyTrayApplication("exe", "Zoom.exe")
IdentifyTrayApplication("exe", "slack.exe")
IdentifyTrayApplication("exe", "QuickLook.exe")
IdentifyTrayApplication("exe", "KensingtonWorks2.exe")
IdentifyTrayApplication("exe", "MovieCatalog.exe")
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

; Identify Object Name Change Applications
; IdentifyObjectNameChangeApplication("exe", "alacritty.exe")

; Identify applications to be forcibly managed
ManageRule("exe", "TIM.exe")
ManageRule("exe", "GalaxyClient.exe")
ManageRule("exe", "Ferdi.exe")
ManageRule("exe", "Tabby.exe")
ManageRule("exe", "alacritty.exe")
ManageRule("exe", "MovieCatalog.exe")

