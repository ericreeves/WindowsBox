#SingleInstance Force
SendMode("Input")
SetWorkingDir(A_ScriptDir)

arr := ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
idx := 0

!x::
{
    global idx += 1
    if ( idx > (arr.Length - 1))
        global idx := 1
    SendInput("^!#{" idx "}")
return
}

!z::
{
    global idx -= 1
    if (idx < 1)
        global idx := (arr.Length - 1)
    SendInput("^!#{" idx "}")
return
}

