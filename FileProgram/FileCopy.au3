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
#include <FileConstants.au3>

; #RequireAdmin

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates

Local  $filePath = @AppDataDir & "\Sublime Text 3\Packages\AutoItScript\Keywords.sublime-completions"

If FileExists($filePath) Then
	FileCopy($filePath, @ScriptDir & "\Keywords.sublime-completions", $FO_OVERWRITE)
Else
	ConsoleWrite("Have error!")
EndIf