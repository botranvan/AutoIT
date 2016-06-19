#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.10.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

HotKeySet("{esc}",'_exit')
$sleep = 1000;

	Sleep(5000)

While 1

	Send("{^F}")
	Sleep($sleep)

	Send("{ENTER}")
	Sleep($sleep)

	MouseClick('left',1006, 643)

	Sleep(2000)
WEnd

Func _exit()
	Exit
EndFunc