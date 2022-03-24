; Create shortcut to this file under: C:\Users\<YOURUSERNAME>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

; # Win (Windows logo key)
; ! Alt
; ^ Control
; + Shift
; & An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.

; https://github.com/ahkscript/awesome-AutoHotkey
; https://autohotkey.com/docs/KeyList.htm
; ------------------------------------------------------------------------------
; https://stackoverflow.com/questions/15706534/hotkey-to-restart-autohotkey-script

; ------------------------------------------------------------------------------
#SingleInstance Force
#installKeybdHook
#Persistent
; Menu, Tray, Icon , Shell32.dll, 25, 1
; TrayTip, AutoHotKey, Started, 1
; SoundBeep, 300, 150

; Start Komorebi if it's not running
If !ProcessExist("komorebi.exe")
{
Run,  C:\Users\eric\scoop\shims\komorebic.exe start, ,Hide,
}

; ------------------------------------------------------------------------------
SetWorkingDir, %A_ScriptDir%

; Komorebi
#Include %A_ScriptDir%\include\komorebic.ahk

; Helper Functions
#Include %A_ScriptDir%\include\Helpers.ahk

; App Launching and Closing Shortcuts
#Include %A_ScriptDir%\include\AppShortcuts.ahk

; Tab == Tab/Hyper
#Include %A_ScriptDir%\include\TabModifier.ahk

; Media Keys using Tab Hyper Key
#Include %A_ScriptDir%\include\Media.ahk

; #Include %A_ScriptDir%\include\AdvancedWindowSnap.ahk
; #Include %A_ScriptDir%\include\AlwaysOnTop.ahk
; #Include %A_ScriptDir%\include\CapsLockTapEscapeHoldControl.ahk
; #Include %A_ScriptDir%\include\Screenshots.ahk
; #Include %A_ScriptDir%\include\DockWin.ahk
; #Include %A_ScriptDir%\include\QuakeTerminal.ahk
; #Include %A_ScriptDir%\include\Misc.ahk
; #Include %A_ScriptDir%\include\LockSleep.ahk
; #Include %A_ScriptDir%\include\Spotlight.ahk
; #Include %A_ScriptDir%\include\TouchCursor.ahk

; ------------------------------------------------------------------------------
; Reload this script (Ctrl+Win+Alt+R)
^!r::
  Reload
Return
