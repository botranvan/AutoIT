$Presse = False

HotKeySet("{End}","ExitTool")
Func ExitTool()
	Exit
EndFunc

HotKeySet("{F5}","Set")
Func Set()
	$Presse = True
EndFunc
           
HotKeySet("{F6}","UnSet")
Func UnSet()
	$Presse = False
EndFunc


While 1
	Sleep(72)
	If $Presse Then
		Send("{space}")
		Sleep(1000)
	EndIf
	tooltip(@sec&@msec&" "&$Presse,0,0)                
WEnd
