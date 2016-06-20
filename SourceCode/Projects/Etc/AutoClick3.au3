#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         LeeSai

 Script Function:
	Auto Click

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

HotKeySet('{ESC}','_exit')
HotKeySet('^+c','_click_toogle')

$Clicking = False

TrayTip('Auto Click','HotKey; Ctrl + Shift + C'&@LF&'Esc to exit',5)


While 1
	;Sleep(72)
	if($Clicking) Then _clicking()
WEnd

Func _clicking()
	ToolTip('Clicking '&@MSEC,0,0)
	MouseClick('left',Default,Default,2,1)
EndFunc

Func _click_toogle()
	$Clicking = Not $Clicking
	ToolTip('')
EndFunc

Func _exit()
	Exit
EndFunc
