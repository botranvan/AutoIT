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
#include <StringConstants.au3>
#include <Array.au3>


; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates

Local $fileOpen = FileOpenDialog("Choose File", @ScriptDir & "\", "AutoScript (*.au3)")
Local $fileHandle = FileOpen($fileOpen)

ConsoleWrite(FileReadLine($fileHandle, 9))