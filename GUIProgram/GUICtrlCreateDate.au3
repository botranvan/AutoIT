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
#include <WinAPIFiles.au3>
#include <GUIConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates

Local  $guiHandle = GUICreate("AutoIT", 210, 100, Default, Default, $WS_CAPTION, $WS_EX_TRANSPARENT)

Local  $comboDate = GUICtrlCreateDate("Choose a date", 5, 20, 200, 30, $DTS_LONGDATEFORMAT, $WS_EX_CLIENTEDGE)
Local  $buttonSend = GUICtrlCreateButton("Send", 50, 60, 110, 30, $BS_CENTER, $WS_EX_WINDOWEDGE)
GUISetState(@SW_SHOW, $guiHandle)
While True
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
		Case $buttonSend
			MsgBox($MB_SYSTEMMODAL, "", GUICtrlRead($comboDate, $GUI_READ_EXTENDED), 1)
	EndSwitch
WEnd