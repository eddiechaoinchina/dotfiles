; WtHotkey.ahk
;
; Help you open Windows Terminal like Unix's terminal. Thanks Daniel Schroeder
; for his post.
;
; Please install "AutoHotkey" to get this script running. Add a shortcut of it
; to autostart menu.

SwitchToWindowsTerminal()
{
  windowHandleId := WinExist("ahk_exe WindowsTerminal.exe")
  windowExistsAlready := windowHandleId > 0

  ; If the Windows Terminal is already open, determine if we should put it in focus or minimize it.
  if (windowExistsAlready = true)
  {
    activeWindowHandleId := WinExist("A")
    windowIsAlreadyActive := activeWindowHandleId == windowHandleId

    if (windowIsAlreadyActive)
    {
      ; Minimize the window.
      WinMinimize, "ahk_id %windowHandleId%"
    }
    else
    {
      ; Put the window in focus.
      WinActivate, "ahk_id %windowHandleId%"
      WinShow, "ahk_id %windowHandleId%"
    }
  }
  ; Else it's not already open, so launch it.
  else
  {
    ; Run, *RunAs wt
    Run, wt
  }
}

; Hotkey to use Ctrl+Alt+T to launch/restore the Windows Terminal.
^!t::SwitchToWindowsTerminal()