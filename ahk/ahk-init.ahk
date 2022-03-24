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

; Start Komorebi if it's not running
; https://github.com/LGUG2Z/komorebi
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

; ------------------------------------------------------------------------------
; Reload this script (Ctrl+Win+Alt+R)
^!r::
  Reload
Return
