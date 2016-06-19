#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:        Sai
 Facebook: 		https://www.facebook.com/tmd18116

 Script Function:
	Control Clip on Chrome

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

ToolTip("staring",0,0)

$pause = False

HotKeySet('{esc}','_exit')
HotKeySet('{pause}','_pause')

_pause()

While 1
	MouseClick('left',Default,Default,3,2)
WEnd

Func _pause()
	$pause = Not $pause
	While $pause
		Sleep(72)
		ToolTip('Pausing')
	WEnd
	ToolTip('')
EndFunc

Func _exit()
	Exit
EndFunc