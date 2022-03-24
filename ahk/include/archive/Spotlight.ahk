; ------------------------------------------------------------------------------
; https://autohotkey.com/board/topic/47476-problem-with-remapping-altspace-to-winkey/

!`::
  Send,^{Esc}
Return

; Map Alt-; to System Menu
!;::
  Hotkey, !Space, Off
  Send,!{Space}
  Input
  Hotkey, !Space, On
Return
