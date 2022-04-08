;
; Media Player Keyboard Commands
;
; ! Alt + Win + <key>
;
!#h::
    Send, {Media_Prev}
Return

!#l::
    Send, {Media_Next}
Return

!#k::
    Send, {Volume_Up}
Return

!#j::
    Send, {Volume_Down}
Return

!#Space::
    Send, {Media_Play_Pause}
Return

!#m::
    Send, {Volume_Mute}
Return

CoordMode, Mouse, Screen

BarX := ((A_ScreenWidth / 20) * 19) - 260
BarY := (A_ScreenHeight / 20) + 52
Volume_ProgressbarOpts = CW000000 CTFFFFFF CBAAAAAA x%BarX% y%BarY% w260 h52 B1 FS8 WM700 WS700 FM8 ZH12 ZY3 C11
Progress Hide %Volume_ProgressbarOpts%,,Volume,,Tahoma

!^WheelDown::
    ChangeVolume("-")
    ; gosub, Volume_Show_OSD
return
return

!^WheelUp::
    ChangeVolume("+")
    ; gosub, Volume_Show_OSD
return
return

ChangeVolume(x)
{ 
    SoundGet, vol, Master, Volume
    if (x = "+")
        nd := Round(vol) < 20 ? 2 : 5
    else
        nd := Round(vol) <= 20 ? 2 : 5
    nv = %x%%nd%
    SoundSet, nv, Master, Volume
    SoundSet, 0, Master, Mute
}

Volume_Show_OSD:
    SoundGet, Volume, Master, Volume
    Progress % Volume := Round(Volume), %Volume% `%
    Progress Show
    SetTimer, Remove_Show_OSD, 500
return

Remove_Show_OSD:
    SetTimer, Remove_Show_OSD, Off
    Progress Hide %Volume_ProgressbarOpts%,,Volume,,Tahoma
return