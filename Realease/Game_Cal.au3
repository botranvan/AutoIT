#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Comment=No Virus
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
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
#include <AutoItConstants.au3>
#include <WinAPIFiles.au3>


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

Local $Point = 0

While True
	Local $varOne = Random(-999, 999, 1)
	Local $varTwo = Random(-999, 999, 1)
	Local $random = Random(1, 5, 1)
	Local $MathFucn
	Local $Operators
	Switch $random
		Case 1
			$Operators = $varOne & "  +  " & $varTwo
			$MathFucn = ($varOne + $varTwo)
		Case 2
			$Operators = $varOne & "  -  " & $varTwo
			$MathFucn = ($varOne - $varTwo)
		Case 3
			$Operators = $varOne & "  *  " & $varTwo
			$MathFucn = ($varOne * $varTwo)
		Case 4
			$Operators = $varOne & "  :  " & $varTwo
			$MathFucn = ($varOne / $varTwo)
		Case Else
			$Operators = "Mod(" & $varOne & ", " & $varTwo & ") Hint: Modulus"
			$MathFucn = Mod($varOne, $varTwo)
	EndSwitch
	Select
		Case $Point >= 0 And $Point < 100
			$titled = "Hãy vận dụng đầu óc đi nào"
		Case $Point >= 100 And $Point <= 1000
			$titled = "Thật là thần thánh"
		Case $Point >= 1000
			$titled = "OMG! Một thiên tài @@"
		Case Else
			$titled = "Đúng là con gà"
	EndSelect

	If $Point >= 0 And $Point < 100 Then
		Local $result = InputBox($titled, "Điểm: " & $Point & @CRLF & @CRLF & "Hãy nhập kết quả của: " & @CRLF & @CRLF & @TAB & $Operators & @CRLF & @CRLF & "Nhấn ESC để thoát.", Default, Default, 320, 320, Default, Default, 4)
	ElseIf $Point < 0 Then
		Local $result = InputBox($titled, "Điểm: " & $Point & @CRLF & @CRLF & "Hãy nhập kết quả của: " & @CRLF & @CRLF & @TAB & $Operators & @CRLF & @CRLF & "Nhấn ESC để thoát.", Default, Default, 320, 320, Default, Default, 30)
	ElseIf $Point >= 100 And $Point <= 1000 Then
		If $Point = 100 Then
			MsgBox($MB_ICONINFORMATION, "", "Woa ... chúc mừng bạn đã tới một cảnh giới mới", 1)
		EndIf
		Local $result = InputBox($titled, "Điểm: " & $Point & @CRLF & @CRLF & "Hãy nhập kết quả của: " & @CRLF & @CRLF & @TAB & $Operators & @CRLF & @CRLF & "Nhấn ESC để thoát.", Default, Default, 320, 320, Default, Default, 3)
	ElseIf $Point > 1000 Then
		Local $result = InputBox($titled, "Điểm: " & $Point & @CRLF & @CRLF & "Hãy nhập kết quả của: " & @CRLF & @CRLF & @TAB & $Operators & @CRLF & @CRLF & "Nhấn ESC để thoát.", Default, Default, 320, 320, Default, Default, 5)
	Else
		Local $result = InputBox($titled, "Điểm: " & $Point & @CRLF & @CRLF & "Hãy nhập kết quả của: " & @CRLF & @CRLF & @TAB & $Operators & @CRLF & @CRLF & "Nhấn ESC để thoát.", Default, Default, 320, 320, Default, Default, 2)
	EndIf
	If $result == $MathFucn Then
		MsgBox($MB_SYSTEMMODAL, "", "Woa ... thông minh vl :v", 0.5)
		$Point += 1
	Else
		MsgBox($MB_SYSTEMMODAL, "", "Ngu ... Óc chó vl :v", 1)
		$Point -= 1
	EndIf
WEnd
