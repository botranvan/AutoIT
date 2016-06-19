;~ Bấm vào $BStep8ChangeTo
GUICtrlSetOnEvent($BStep8ChangeTo, "BStep8ChangeToClick")
Func BStep8ChangeToClick()
	FCTStep8ChangeTo()
EndFunc


;~ BStep8ChangeToTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func BStep8ChangeToTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "BStep8ChangeTo"

	$Text = FT($ControlID,BStep8ChangeToGet())

	BStep8ChangeToSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func BStep8ChangeToSave()
	IniWrite($DataFile,"Setting","BStep8ChangeTo",BStep8ChangeToGet())
EndFunc

;Nạp giá trị của label từ file
Func BStep8ChangeToLoad()
	Local $Data = IniRead($DataFile,"Setting","BStep8ChangeTo",BStep8ChangeToGet())
	BStep8ChangeToSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $BStep8ChangeTo
Func BStep8ChangeToGet()
	Return GUICtrlRead($BStep8ChangeTo)
EndFunc
;~ Lấy giá trị từ $BStep8ChangeTo
Func BStep8ChangeToSet($NewValue = "")
	Local $Check = BStep8ChangeToGet()
	If $Check <> $NewValue Then GUICtrlSetData($BStep8ChangeTo,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $BStep8ChangeTo
Func BStep8ChangeToGetPos()
	Return ControlGetPos($MainGUI, "", $BStep8ChangeTo)
EndFunc
;~ Chỉnh vị trí của $BStep8ChangeTo
Func BStep8ChangeToSetPos($x = -1,$y = -1)
	Local $Size = BStep8ChangeToGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BStep8ChangeTo,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BStep8ChangeTo
Func BStep8ChangeToSetSize($Width = -1,$Height = -1)
	Local $Size = BStep8ChangeToGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BStep8ChangeTo,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BStep8ChangeTo
Func BStep8ChangeToGetState()
	Return GUICtrlGetState($BStep8ChangeTo)
EndFunc
Func BStep8ChangeToSetState($State = $GUI_SHOW)
	GUICtrlSetState($BStep8ChangeTo,$State)
EndFunc


;~ Chỉnh màu chữ của $BStep8ChangeTo
Func BStep8ChangeToColor($Color = 0x000000)
	GUICtrlSetColor($BStep8ChangeTo,$Color)
EndFunc
;~ Chỉnh màu nền của $BStep8ChangeTo
Func BStep8ChangeToBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BStep8ChangeTo,$Color)
EndFunc