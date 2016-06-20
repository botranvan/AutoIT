;~ Bấm vào $BStep2ChangeTo
GUICtrlSetOnEvent($BStep2ChangeTo, "BStep2ChangeToClick")
Func BStep2ChangeToClick()
	FCTStep2ChangeTo()
EndFunc


;~ BStep2ChangeToTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func BStep2ChangeToTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "BStep2ChangeTo"

	$Text = FT($ControlID,BStep2ChangeToGet())

	BStep2ChangeToSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func BStep2ChangeToSave()
	IniWrite($DataFile,"Setting","BStep2ChangeTo",BStep2ChangeToGet())
EndFunc

;Nạp giá trị của label từ file
Func BStep2ChangeToLoad()
	Local $Data = IniRead($DataFile,"Setting","BStep2ChangeTo",BStep2ChangeToGet())
	BStep2ChangeToSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $BStep2ChangeTo
Func BStep2ChangeToGet()
	Return GUICtrlRead($BStep2ChangeTo)
EndFunc
;~ Lấy giá trị từ $BStep2ChangeTo
Func BStep2ChangeToSet($NewValue = "")
	Local $Check = BStep2ChangeToGet()
	If $Check <> $NewValue Then GUICtrlSetData($BStep2ChangeTo,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $BStep2ChangeTo
Func BStep2ChangeToGetPos()
	Return ControlGetPos($MainGUI, "", $BStep2ChangeTo)
EndFunc
;~ Chỉnh vị trí của $BStep2ChangeTo
Func BStep2ChangeToSetPos($x = -1,$y = -1)
	Local $Size = BStep2ChangeToGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BStep2ChangeTo,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BStep2ChangeTo
Func BStep2ChangeToSetSize($Width = -1,$Height = -1)
	Local $Size = BStep2ChangeToGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BStep2ChangeTo,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BStep2ChangeTo
Func BStep2ChangeToGetState()
	Return GUICtrlGetState($BStep2ChangeTo)
EndFunc
Func BStep2ChangeToSetState($State = $GUI_SHOW)
	GUICtrlSetState($BStep2ChangeTo,$State)
EndFunc


;~ Chỉnh màu chữ của $BStep2ChangeTo
Func BStep2ChangeToColor($Color = 0x000000)
	GUICtrlSetColor($BStep2ChangeTo,$Color)
EndFunc
;~ Chỉnh màu nền của $BStep2ChangeTo
Func BStep2ChangeToBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BStep2ChangeTo,$Color)
EndFunc