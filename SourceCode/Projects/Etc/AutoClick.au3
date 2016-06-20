#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:        Sai
 Facebook: 		https://www.facebook.com/tmd18116

 Script Function:
	Control Clip on Chrome

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

ToolTip("staring",0,0)
Sleep(3000)

HotKeySet('{esc}','_exit')

$title = "[REGEXPTITLE:(?i)(.*Google Chrome*)]"
$count = 0

$control_id = 219616320
$row_start = 0
While 1
	Sleep(1000)

	While 1
		Sleep(500)
		ControlClick($title,'',$control_id,'left',2, 656, 590)

		$row_start_new = 0
		Sleep(500)
;~ 		ControlSend($title,'',$control_id,"^c")
		Send("^c")
		$row_start_new = ClipGet()*1
		ToolTip("$row_start: "&$row_start,0,0)

		If($row_start_new > $row_start Or $row_start_new==0) Then
			$row_start = $row_start_new
			ExitLoop
		EndIf

		Sleep(500);
	WEnd

;~ 	3 times click on current text

	ControlClick($title,'',$control_id,'left',1,362, 298)

;~ 	Set text for search input
;~ 	Sleep(1000)
;~ 	ControlSend($title,'',$control_id,"{END}")


;~ 	MouseClick('left')

	$count+=1
	ToolTip("$count:"&$count,0,0)
WEnd

Func _exit()
	Exit
EndFunc