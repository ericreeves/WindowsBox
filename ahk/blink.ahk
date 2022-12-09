#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

#Persistent
Gui +LastFound
hWnd := WinExist()

DllCall("RegisterShellHookWindow", UInt,hWnd)
MsgNum := DllCall("RegisterWindowMessage", Str,"SHELLHOOK")
OnMessage(MsgNum, "ShellMessage")
Return

ShellMessage(wParam,lParam) {
  Local k
  if (wParam = 32772){
    SetTimer, DrawRect, -1
  }
}


;======================================


DrawRect:
  
  border_thickness := 1
  ; border_color := E69EB2
  WinGetPos, x, y, w, h, A
  if (x="")
      return
  Gui, +Lastfound +AlwaysOnTop +Toolwindow +HwndMyGuiHwnd

  borderType:="inside"                ; set to inside, outside, or both

  if (borderType="outside") { 
      outerX:=0
      outerY:=0
      outerX2:=w+2*border_thickness
      outerY2:=h+2*border_thickness

      innerX:=border_thickness
      innerY:=border_thickness
      innerX2:=border_thickness+w
      innerY2:=border_thickness+h

      newX:=x-border_thickness
      newY:=y-border_thickness
      newW:=w+2*border_thickness
      newH:=h+2*border_thickness

  } else if (borderType="inside") {   
      WinGet, myState, MinMax, A
      if (myState=1)
          offset:=1
      else 
          offset:=0

      outerX:=offset
      outerY:=offset
      outerX2:=w-offset
      outerY2:=h-offset

      innerX:=border_thickness+offset
      innerY:=border_thickness+offset
      innerX2:=w-border_thickness-offset
      innerY2:=h-border_thickness-offset

      newX:=x
      newY:=y
      newW:=w
      newH:=h



  } else if (borderType="both") { 
      outerX:=0
      outerY:=0
      outerX2:=w+2*border_thickness
      outerY2:=h+2*border_thickness

      innerX:=border_thickness*2
      innerY:=border_thickness*2
      innerX2:=w
      innerY2:=h

      newX:=x-border_thickness
      newY:=y-border_thickness
      newW:=w+4*border_thickness
      newH:=h+4*border_thickness
  }



  ; Gui, Color, %border_color%
  Gui, Color, 216FED
  Gui, -Caption

  ;WinSet, Region, 0-0 %w%-0 %w%-%h% 0-%h% 0-0 %border_thickness%-%border_thickness% %iw%-%border_thickness% %iw%-%ih% %border_thickness%-%ih% %border_thickness%-%border_thickness%
  WinSet, Region, %outerX%-%outerY% %outerX2%-%outerY% %outerX2%-%outerY2% %outerX%-%outerY2% %outerX%-%outerY%    %innerX%-%innerY% %innerX2%-%innerY% %innerX2%-%innerY2% %innerX%-%innerY2% %innerX%-%innerY% 


  ;Gui, Show, w%w% h%h% x%x% y%y% NoActivate, Table awaiting Action
  Gui, Show, w%newW% h%newH% x%newX% y%newY% NoActivate, Table awaiting Action
  AW_BLEND	:= 0x00080000	; Uses a fade effect.
  AW_HIDE	:= 0x00010000	; Hides the window. By default, the window is shown.
  DllCall("AnimateWindow","UInt",MyGuiHwnd,"Int",300,"UInt",AW_BLEND|AW_HIDE)
Return