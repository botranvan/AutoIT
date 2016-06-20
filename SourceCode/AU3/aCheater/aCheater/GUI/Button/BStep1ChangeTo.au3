;~ Bấm vào $BStep1ChangeTo
GUICtrlSetOnEvent($BStep1ChangeTo, "BStep1ChangeToClick")
Func BStep1ChangeToClick()
	FCTStep1ChangeTo()
EndFunc


;~ BStep1ChangeToTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func BStep1ChangeToTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "BStep1ChangeTo"

	$Text = FT($ControlID,BStep1ChangeToGet())

	BStep1ChangeToSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func BStep1ChangeToSave()
	IniWrite($DataFile,"Setting","BStep1ChangeTo",BStep1ChangeToGet())
EndFunc

;Nạp giá trị của label từ file
Func BStep1ChangeToLoad()
	Local $Data = IniRead($DataFile,"Setting","BStep1ChangeTo",BStep1ChangeToGet())
	BStep1ChangeToSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $BStep1ChangeTo
Func BStep1ChangeToGet()
	Return GUICtrlRead($BStep1ChangeTo)
EndFunc
;~ Lấy giá trị từ $BStep1ChangeTo
Func BStep1ChangeToSet($NewValue = "")
	Local $Check = BStep1ChangeToGet()
	If $Check <> $NewValue Then GUICtrlSetData($BStep1ChangeTo,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $BStep1ChangeTo
Func BStep1ChangeToGetPos()
	Return ControlGetPos($MainGUI, "", $BStep1ChangeTo)
EndFunc
;~ Chỉnh vị trí của $BStep1ChangeTo
Func BStep1ChangeToSetPos($x = -1,$y = -1)
	Local $Size = BStep1ChangeToGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BStep1ChangeTo,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BStep1ChangeTo
Func BStep1ChangeToSetSize($Width = -1,$Height = -1)
	Local $Size = BStep1ChangeToGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BStep1ChangeTo,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BStep1ChangeTo
Func BStep1ChangeToGetState()
	Return GUICtrlGetState($BStep1ChangeTo)
EndFunc
Func BStep1ChangeToSetState($State = $GUI_SHOW)
	GUICtrlSetState($BStep1ChangeTo,$State)
EndFunc


;~ Chỉnh màu chữ của $BStep1ChangeTo
Func BStep1ChangeToColor($Color = 0x000000)
	GUICtrlSetColor($BStep1ChangeTo,$Color)
EndFunc
;~ Chỉnh màu nền của $BStep1ChangeTo
Func BStep1ChangeToBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BStep1ChangeTo,$Color)
EndFunc