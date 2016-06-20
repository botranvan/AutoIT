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

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	MsgBox($MB_ICONINFORMATION, "", "Exiting ...", 0.5)
	Exit
EndFunc   ;==>_Terminates
#comments-start
	#OnAutoItStartRegister "_RunProcess"
	Func _RunProcess()
	Local $objShell = ObjCreate("Shell.Application")
	$objShell.MinimizeAll
	EndFunc   ;==>_RunProcess
#comments-end

Global  $GUI = GUICreate("Auto IT", 240, 320)

GUISetState(@SW_SHOW)

While TRUE
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
	EndSwitch
WEnd