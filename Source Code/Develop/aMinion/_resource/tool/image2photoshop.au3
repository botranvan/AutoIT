#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.10.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

HotKeySet("{esc}",'_exit')
$sleep = 500;

	Sleep(5000)

While 1

	Send("!w")
	Sleep($sleep)

	Send("2")
	Sleep($sleep)

	Send("^a")
	Sleep($sleep)

	Send("^c")
	Sleep($sleep)

	Send("^w")
	Sleep($sleep)

	Send("^v")
	Sleep($sleep)

	Sleep(1000)
WEnd

Func _exit()
	Exit
EndFunc