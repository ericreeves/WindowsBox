; LockWorkStation and turn monitor off
#+^Tab::
{
  Sleep, 200
  DllCall("LockWorkStation")
  Sleep, 1000

  ; Turn off monitor
  ; 0x112 == WM_SYSCOMMAND, 0xF170 == SC_MONITORPOWER
; SendMessage,0x112,0xF170,2,,Program Manager

  ; Sleep/Suspend:
  DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)

  ; Hibernate:
; DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)

  Return
}
Return