HotKeySet("{End}","ExitAuto")
HotKeySet("p","PauseAuto")

Global $Pause = 0
Global $CheckPos
Global $IsTrap = 0
Global $Message = ""

;Tọa độ bẫy chuột
$Left = 100 	;x - 0
$Top = 100		;y - 1
$Right = 300	;x - 0
$Bottom = 300	;y - 1

;Vòng lặp giữ chương trình
While 1
	Sleep(77)

	;Lấy vị trí chuột
	$CheckPos = MouseGetPos()
	tooltip(@sec&@msec&" - "&$CheckPos[0]&"/"&$CheckPos[1]&$Message,0,0)

	;Kích hoạt bẫy khi chuột dính bẫy
	If $CheckPos[0] > $Left And $CheckPos[1] > $Top And $CheckPos[0] < $Right And $CheckPos[1] < $Bottom Then $IsTrap = 1

	;Kiểm tra xem chuột dính bẫy chưa
	If $IsTrap Then
		$Message = " Dính Bẫy"
		If $CheckPos[0] < $Left or $CheckPos[1] < $Top or $CheckPos[0] > $Right or $CheckPos[1] > $Bottom Then
			$Message&= @lf&"Cố thoát"
			If $CheckPos[0] < $Left Then MouseMove($Left,$CheckPos[1],1)
			If $CheckPos[1] < $Top Then MouseMove($CheckPos[0],$Top,1)
			If $CheckPos[0] > $Right Then MouseMove($Right,$CheckPos[1],1)
			If $CheckPos[1] > $Bottom Then MouseMove($CheckPos[0],$Bottom,1)
		EndIf
	Else
		$Message = " Tự Do"
	EndIf
WEnd


;~ Tạm dừng Auto
Func PauseAuto()
	$Pause = Not $Pause
	While $Pause
		tooltip("Pause",0,0)
	WEnd

	;Thả chuột ra khi Pause
	$IsTrap = 0
EndFunc

;Thoát chương trình
Func ExitAuto()
	Exit
EndFunc