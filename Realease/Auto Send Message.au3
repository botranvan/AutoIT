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
HotKeySet("{F1}", "_Main")
HotKeySet("{F2}", "_Input_Number")
HotKeySet("{F3}", "_Send_Message")
; #OnAutoItStartRegister "_RunProcess"
; Func _RunProcess()
; 	Local $objShell = ObjCreate("Shell.Application")
; 	$objShell.MinimizeAll
; EndFunc   ;==>_RunProcess
OnAutoItExitRegister("_ExitProcess")
Func _ExitProcess()
	MsgBox($MB_ICONINFORMATION, "Exiting", "Đang dừng...", 1)
EndFunc   ;==>_ExitProcess
While True
	Sleep(10000)
WEnd
Global Const $Data_Clip_Board = ClipGet()
ClipPut($Data_Clip_Board)
Global  $time_to_send = 500
Func _Main()
	;code
	Global $sMessage = InputBox("Auto Messenger", "Nhập tin nhắn muốn gửi!" & _
			@CRLF & "Các tin nhắn cách nhau bằng ký tự | ", Default, Default, Default, Default, Default, Default, Default)
	Global $sSplit_Message = StringSplit($sMessage, "|", $STR_CHRSPLIT)
EndFunc   ;==>_Main
Func _Input_Number()
	;code
	Global $iMessages = InputBox("Auto Messenger", "Số tin nhắn cần gửi", "", "", Default, Default, Default, Default, Default)
EndFunc   ;==>_RunProg
Func _Send_Message()
	;code
	For $i = 1 To $iMessages
		Call("_Choose_Message_To_Send")
	Next
EndFunc
Func _Choose_Message_To_Send()
	;code
	If $sSplit_Message[0] == 1 Then
		ClipPut($sSplit_Message[1])
		Sleep($time_to_send)
		Send("^v {ENTER}")
	Else
		ClipPut($sSplit_Message[Random(1, $sSplit_Message[0], 1)])
		Sleep(100)
		Send("^v {ENTER}")
	EndIf
EndFunc   ;==>_Choose_Message_To_Send