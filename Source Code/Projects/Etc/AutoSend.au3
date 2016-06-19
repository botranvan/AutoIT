#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:        Sai
 Facebook: 		https://www.facebook.com/tmd18116

 Script Function:
	Auto send key

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

ToolTip("staring",0,0)
Sleep(3000)

HotKeySet('{esc}','_exit')

$text = "',"
ClipPut($text)

$count = 0
$speed = 100
While 1
	Sleep($speed*2)

	Send("'")
	Sleep($speed)

	Send('{end}')
	Sleep($speed)

	Send('^v')
	Sleep($speed)

	Send('{down}')
	Sleep($speed)

	Send('{home}')
	Sleep($speed)

	$count+=1
	ToolTip("$count:"&$count,0,0)

WEnd

Func _exit()
	Exit
EndFunc