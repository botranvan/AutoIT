; #NoTrayIcon
#include <MsgBoxConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates


Run("notepad")

; Wait 10 seconds for the Notepad window to appear.
WinWaitActive("[CLASS:Notepad]")
; Local $hWnd = WinWait("[CLASS:Notepad]", "", 10)
Opt('SendKeyDownDelay', 1) ;1 millisecond
Opt('SendKeyDownDelay', 1) ;1 millisecond
Opt('SendAttachMode', 0) ;0=don't attach, 1=do attach
Opt('SendCapslockMode', 1) ;1=store and restore, 0=don't

Send("Hello World")
Send("{ENTER}")

; Keep the Notepad window active when using the Send function.
SendKeepActive("[CLASS:Notepad]")

; Simulate entering a string of text. If you try to change to a different window other than Notepad, then the Notepad window will
; be brought to focus again.
For $i = 1 To 10
    Sleep(500)
    Send("notepad - ")
Next

; Disable the Notepad window being active when using the Send function.
SendKeepActive("")

; Close the Notepad window using the handle returned by WinWait.
; WinClose($hWnd)

; Now a screen will pop up and ask to save the changes, the classname of the window is called
; "#32770" and simulating the "TAB" key to move to the second button in which the "ENTER" is simulated to not "save the file"
WinWaitActive("[CLASS:#32770]")
Sleep(500)
Send("{TAB}{ENTER}")


