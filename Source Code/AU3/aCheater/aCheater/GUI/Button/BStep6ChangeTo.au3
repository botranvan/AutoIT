;~ Bấm vào $BStep6ChangeTo
GUICtrlSetOnEvent($BStep6ChangeTo, "BStep6ChangeToClick")
Func BStep6ChangeToClick()
	FCTStep6ChangeTo()
EndFunc


;~ BStep6ChangeToTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func BStep6ChangeToTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "BStep6ChangeTo"

	$Text = FT($ControlID,BStep6ChangeToGet())

	BStep6ChangeToSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func BStep6ChangeToSave()
	IniWrite($DataFile,"Setting","BStep6ChangeTo",BStep6ChangeToGet())
EndFunc

;Nạp giá trị của label từ file
Func BStep6ChangeToLoad()
	Local $Data = IniRead($DataFile,"Setting","BStep6ChangeTo",BStep6ChangeToGet())
	BStep6ChangeToSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $BStep6ChangeTo
Func BStep6ChangeToGet()
	Return GUICtrlRead($BStep6ChangeTo)
EndFunc
;~ Lấy giá trị từ $BStep6ChangeTo
Func BStep6ChangeToSet($NewValue = "")
	Local $Check = BStep6ChangeToGet()
	If $Check <> $NewValue Then GUICtrlSetData($BStep6ChangeTo,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $BStep6ChangeTo
Func BStep6ChangeToGetPos()
	Return ControlGetPos($MainGUI, "", $BStep6ChangeTo)
EndFunc
;~ Chỉnh vị trí của $BStep6ChangeTo
Func BStep6ChangeToSetPos($x = -1,$y = -1)
	Local $Size = BStep6ChangeToGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BStep6ChangeTo,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BStep6ChangeTo
Func BStep6ChangeToSetSize($Width = -1,$Height = -1)
	Local $Size = BStep6ChangeToGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BStep6ChangeTo,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BStep6ChangeTo
Func BStep6ChangeToGetState()
	Return GUICtrlGetState($BStep6ChangeTo)
EndFunc
Func BStep6ChangeToSetState($State = $GUI_SHOW)
	GUICtrlSetState($BStep6ChangeTo,$State)
EndFunc


;~ Chỉnh màu chữ của $BStep6ChangeTo
Func BStep6ChangeToColor($Color = 0x000000)
	GUICtrlSetColor($BStep6ChangeTo,$Color)
EndFunc
;~ Chỉnh màu nền của $BStep6ChangeTo
Func BStep6ChangeToBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BStep6ChangeTo,$Color)
EndFunc