;~ Bấm vào $IStep6ChangeTo
GUICtrlSetOnEvent($IStep6ChangeTo, "IStep6ChangeToChange")
Func IStep6ChangeToChange()
;~	MsgBox(0,"72ls.NET","IStep6ChangeToChange")
	IStep6ChangeToSave()
EndFunc

;~ IStep6ChangeToTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IStep6ChangeToTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IStep6ChangeTo"

	$Text = FT($ControlID,IStep6ChangeToGet())

	IStep6ChangeToSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IStep6ChangeToTSave()
    FTWrite('IStep6ChangeTo',IStep6ChangeToGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IStep6ChangeToSave()
	IniWrite($DataFile,"Setting","IStep6ChangeTo",IStep6ChangeToGet())
EndFunc

;Nạp giá trị của label từ file
IStep6ChangeToLoad()
Func IStep6ChangeToLoad()
	Local $Data = IniRead($DataFile,"Setting","IStep6ChangeTo",IStep6ChangeToGet())
	IStep6ChangeToSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IStep6ChangeTo
Func IStep6ChangeToGet()
	Return GUICtrlRead($IStep6ChangeTo)
EndFunc
;~ Lấy giá trị từ $IStep6ChangeTo
Func IStep6ChangeToSet($NewValue = "")
	Local $Check = IStep6ChangeToGet()
	If $Check <> $NewValue Then GUICtrlSetData($IStep6ChangeTo,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IStep6ChangeTo
Func IStep6ChangeToGetPos()
	Return ControlGetPos($MainGUI, "", $IStep6ChangeTo)
EndFunc
;~ Chỉnh vị trí của $IStep6ChangeTo
Func IStep6ChangeToSetPos($x = -1,$y = -1)
	Local $Size = IStep6ChangeToGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IStep6ChangeTo,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IStep6ChangeTo
Func IStep6ChangeToSetSize($Width = -1,$Height = -1)
	Local $Size = IStep6ChangeToGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IStep6ChangeTo,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IStep6ChangeTo
Func IStep6ChangeToGetState()
	Return GUICtrlGetState($IStep6ChangeTo)
EndFunc
Func IStep6ChangeToSetState($State = $GUI_SHOW)
	GUICtrlSetState($IStep6ChangeTo,$State)
EndFunc


;~ Chỉnh màu chữ của $IStep6ChangeTo
Func IStep6ChangeToColor($Color = 0x000000)
	GUICtrlSetColor($IStep6ChangeTo,$Color)
EndFunc
;~ Chỉnh màu nền của $IStep6ChangeTo
Func IStep6ChangeToBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IStep6ChangeTo,$Color)
EndFunc