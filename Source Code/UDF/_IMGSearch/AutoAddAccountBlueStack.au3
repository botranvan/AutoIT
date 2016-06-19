#include "_IMGSearch.au3"
#include "_IMGSearch_Debug.au3"
;~ HotKeySet('{esc}', '_Q')
;~ Global $out = False
;~ for example
$m = 'emailgido@gmail.com'
$p = '123456'
Local $BS = WinGetPos('BlueStacks App Player')
WinActive('BlueStacks App Player')
Local $img


For $i = 1 To 7 Step +1
	$img = _IMGSearch_WaitArea(@ScriptDir & '\File' & $i & '.bmp', 10000, $BS[0], $BS[1], $BS[0] + $BS[2], $BS[1] + $BS[3])
	MouseClick('left', $img[1], $img[2])
	Sleep(500)
	If $i == 5 Then
		Send($m)
		Send("{tab}")
		Send($p)
	EndIf

Next



;~ Local $a = 1
;~ While 1
;~ 	MsgBox(0, $a, 'Press OK then drag to create bmp')
;~ 	_IMGSearch_Create_BMP('File' & $a & '.bmp')
;~ 	$a += 1
;~ 	If $out == True Then ExitLoop
;~ WEnd

;~ Func _Q()
;~ 	$out = True
;~ EndFunc   ;==>_Q
