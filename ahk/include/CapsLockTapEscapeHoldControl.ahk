; https://superuser.com/questions/581692/remap-caps-lock-in-windows-escape-and-control
;   Switched from SharpKeys remapping of CapsLock to Ctrl to this
*CapsLock::
  Send {Blind}{Ctrl Down}
  cDown := A_TickCount
Return

*CapsLock up::
  If ((A_TickCount-cDown)<200)  ; Modify press time as needed (milliseconds)
    Send {Blind}{Ctrl Up}{Esc}
  Else
    Send {Blind}{Ctrl Up}
Return
