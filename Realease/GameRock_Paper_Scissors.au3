#pragma compile(Compatibility, win81)
#pragma compile(Compression, 9)
#pragma compile(ExecLevel,highestAvailable)
#pragma compile(FileVersion, 1.0.0)
#pragma compile(FileDescription, No Virus)
#pragma compile(Icon, source/icons/au3script_v2.ico)
#pragma compile(LegalCopyright, Researcher)
#pragma compile(OriginalFilename, show_love.exe)
#pragma compile(ProductName, Virus I Love You)
#pragma compile(ProductVersion, 1.0)
#pragma compile(UPX, true)


; #NoTrayIcon

#include <MsgBoxConstants.au3>

HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates


Func compare($userChoice, $computerChoice)
	;Definition variables
	If ($computerChoice >= 0) And ($computerChoice <= 0.33) Then
		$computerChoice = "rock"
	ElseIf ($computerChoice >= 0.34) And ($computerChoice <= 0.66) Then
		$computerChoice = "paper"
	Else
		$computerChoice = "scissors"
	EndIf
	;Processing datas
	If $userChoice == $computerChoice Then
		MsgBox($MB_OK, "The Result", "Your choice: " & $userChoice & @CRLF & _
				"Computer: " & $computerChoice & @CRLF & "Oops!!" & @CRLF & "Play again?")
	ElseIf $userChoice == "rock" Then
		If $computerChoice == "scissors" Then
			MsgBox($MB_OK, "The Result", "Your choice: " & $userChoice & @CRLF & _
					"Computer: " & $computerChoice & @CRLF & "You wins because:  " & $userChoice & " beat " & $computerChoice)
		Else
			MsgBox($MB_OK, "The Result", "Your choice: " & $userChoice & @CRLF & _
					"Computer: " & $computerChoice & @CRLF & "You fails because:  " & $computerChoice & " beat " & $userChoice)
		EndIf
	ElseIf $userChoice == "paper" Then
		If $computerChoice == "rock" Then
			MsgBox($MB_OK, "The Result", "Your choice: " & $userChoice & @CRLF & _
					"Computer: " & $computerChoice & @CRLF & "You wins because:  " & $userChoice & " beat " & $computerChoice)
		Else
			MsgBox($MB_OK, "The Result", "Your choice: " & $userChoice & @CRLF & _
					"Computer: " & $computerChoice & @CRLF & "You fails because:  " & $computerChoice & " beat " & $userChoice)
		EndIf
	ElseIf $userChoice == "scissors" Then
		If $computerChoice == "paper" Then
			MsgBox($MB_OK, "The Result", "Your choice: " & $userChoice & @CRLF & _
					"Computer: " & $computerChoice & @CRLF & "You wins because:  " & $userChoice & " beat " & $computerChoice)
		Else
			MsgBox($MB_OK, "The Result", "Your choice: " & $userChoice & @CRLF & _
					"Computer: " & $computerChoice & @CRLF & "You fails because:  " & $computerChoice & " beat " & $userChoice)
		EndIf
	EndIf
EndFunc   ;==>compare

Do
	Do
		$userChoice = InputBox("Your choice", "Input your choice in here.", "rock || paper || scissors")
		;Test input data is valid Or Invalid?
		If $userChoice <> "rock" And $userChoice <> "paper" And $userChoice <> "scissors" Then
			MsgBox($MB_ICONINFORMATION, "Error!", "Input data invalid! Now, input again!")
		EndIf
	Until $userChoice == "rock" Or $userChoice == "scissors" Or $userChoice == "paper"

	$computerChoice = Random(0, 1)

	compare($userChoice, $computerChoice)

	$choose = MsgBox($MB_YESNO, "Continue?", "You want continue?")
Until $choose == 7


