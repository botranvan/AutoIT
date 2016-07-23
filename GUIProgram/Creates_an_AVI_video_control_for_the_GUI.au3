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
Local  $guiHandle = GUICreate("AutoIT", 320, 320, Default, Default, $WS_CAPTION + $WS_POPUP, $WS_EX_TRANSPARENT)
Local  $guiAvi = GUICtrlCreateAvi(@SystemDir & "\shell32.dll", 165, 15, 0,300)
Local  $buttonSend = GUICtrlCreateButton("Start", 5, 285, 90, 30)
Local  $buttonCancel = GUICtrlCreateButton("Stop", 225, 285, 90, 30)
GUISetState(@SW_SHOW, $guiHandle)
While True
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $buttonSend
			GUICtrlSetState($guiAvi, $GUI_AVISTART)
		Case $buttonCancel
			GUICtrlSetState($guiAvi, $GUI_AVISTOP)
	EndSwitch
WEnd