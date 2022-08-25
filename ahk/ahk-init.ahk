; Create shortcut to this file under: C:\Users\<YOURUSERNAME>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
; Win + r, shell:startup

; # Win (Windows logo key)
; ! Alt
; ^ Control
; + Shift
; & An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.
; ------------------------------------------------------------------------------
#SingleInstance Force
#Persistent
#NoEnv                                    ; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir, %A_ScriptDir%

; Set Working Directory for All Subsequent Includes
#Include %A_ScriptDir%

; App Launching and Closing Shortcuts
#Include %A_ScriptDir%\include\AppShortcuts.ahk

; Media Keys using Alt + Win
; #Include %A_ScriptDir%\include\Media.ahk