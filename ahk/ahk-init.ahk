; Create shortcut to this file under: C:\Users\<YOURUSERNAME>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
; Win + r, shell:startup

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
#Persistent
#NoEnv                                    ; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir, %A_ScriptDir%

; ------------------------------------------------------------------------------
; Start komorebi
; ------------------------------------------------------------------------------
RunWait, PowerShell.exe -ExecutionPolicy Bypass -File "%A_ScriptDir%\scripts\Start-Komorebi.ps1", ,Hide,
; ------------------------------------------------------------------------------

; Komorebi
#Include %A_ScriptDir%\include\komorebi.ahk

; Helper Functions
#Include %A_ScriptDir%\include\Helpers.ahk

; App Launching and Closing Shortcuts
#Include %A_ScriptDir%\include\AppShortcuts.ahk

; Media Keys using Alt + Win
#Include %A_ScriptDir%\include\Media.ahk

; Helper Functions
#Include %A_ScriptDir%\include\Helpers.ahk

