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

; Start Komorebi if it's not running
; https://github.com/LGUG2Z/komorebi
; If !ProcessExist("komorebi.exe")
; {
; RunWait, C:\Users\eric\.cargo\bin\komorebi.exe start, ,Hide,
; }

; ------------------------------------------------------------------------------
SetWorkingDir, %A_ScriptDir%

; Komorebi
#Include %A_ScriptDir%\include\komorebic.ahk

; Helper Functions
#Include %A_ScriptDir%\include\Helpers.ahk

; App Launching and Closing Shortcuts
#Include %A_ScriptDir%\include\AppShortcuts.ahk

; Media Keys using Alt + Win
#Include %A_ScriptDir%\include\Media.ahk

; Reload this script 
; Ctrl + Win + Alt + r
^#!r::
  Reload
Return
