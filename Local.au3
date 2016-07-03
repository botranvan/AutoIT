#pragma compile(Compatibility, win81)
#pragma compile(Compression, 9)
#pragma compile(ExecLevel,highestAvailable)
#pragma compile(Fileversion, 1.0.0.1)
#pragma compile(FileDescription, No Virus)
#pragma compile(Icon, source/icons/script.ico)
#pragma compile(LegalCopyright, Researcher)
#pragma compile(OriginalFilename, Constructor)
#pragma compile(ProductName, Beta.Version)
#pragma compile(ProductVersion, 1.0)
; #NoTrayIcon
#include <MsgBoxConstants.au3>
#include <GUIConstants.au3>
#include <WindowsConstants.au3>


; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates
; Use -1 to combine $WS_MINIMIZEBOX + $WS_CAPTION + $WS_POPUP +  $WS_SYSMENU
Local  $guiHandle = GUICreate("AutoIT", 240, 320, Default, Default, $WS_CAPTION + $WS_POPUP, $WS_EX_TRANSPARENT)
Local  $buttonSend = GUICtrlCreateButton("Send", 5, 285, 90, 30)
Local  $buttonCancel = GUICtrlCreateButton("Cancel", 145, 285, 90, 30)
GUISetState(@SW_SHOW, $guiHandle)
ConsoleWrite(GUICtrlRead($buttonSend, $GUI_READ_EXTENDED))
While True
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
	EndSwitch
WEnd
