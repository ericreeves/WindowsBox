; Escape Closes Things!
$Escape::                                               ; Long press (> 0.5 sec) on Esc closes window
    KeyWait, Escape, T0.5                               ; Wait no more than 0.5 sec for key release (also suppress auto-repeat)
    If ErrorLevel                                       ; timeout, so long press
        PostMessage, 0x112, 0xF060,,, A                 ; ...close window
    Else                                                ; otherwise...
        Send {Esc}                                       ; ...just send Escape
Return

; Alt-W and Alt-Q Close Windows
!w::WinClose A
!q::WinClose A

; Application Shortcuts
!Enter::
  Run, "C:\Program Files\Alacritty\alacritty.exe"
;-e wsl.exe --cd ~ -- /usr/bin/zsh -c "/home/linuxbrew/.linuxbrew/bin/tmux attach || tmux"
Return

!b::
  Run, Firefox.exe
Return