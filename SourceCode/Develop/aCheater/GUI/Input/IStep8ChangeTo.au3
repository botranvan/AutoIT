;~ Bấm vào $IStep8ChangeTo
GUICtrlSetOnEvent($IStep8ChangeTo, "IStep8ChangeToChange")
Func IStep8ChangeToChange()
;~	MsgBox(0,"72ls.NET","IStep8ChangeToChange")
	IStep8ChangeToSave()
EndFunc

;~ IStep8ChangeToTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IStep8ChangeToTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IStep8ChangeTo"

	$Text = FT($ControlID,IStep8ChangeToGet())

	IStep8ChangeToSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IStep8ChangeToTSave()
    FTWrite('IStep8ChangeTo',IStep8ChangeToGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IStep8ChangeToSave()
	IniWrite($DataFile,"Setting","IStep8ChangeTo",IStep8ChangeToGet())
EndFunc

;Nạp giá trị của label từ file
IStep8ChangeToLoad()
Func IStep8ChangeToLoad()
	Local $Data = IniRead($DataFile,"Setting","IStep8ChangeTo",IStep8ChangeToGet())
	IStep8ChangeToSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IStep8ChangeTo
Func IStep8ChangeToGet()
	Return GUICtrlRead($IStep8ChangeTo)
EndFunc
;~ Lấy giá trị từ $IStep8ChangeTo
Func IStep8ChangeToSet($NewValue = "")
	Local $Check = IStep8ChangeToGet()
	If $Check <> $NewValue Then GUICtrlSetData($IStep8ChangeTo,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IStep8ChangeTo
Func IStep8ChangeToGetPos()
	Return ControlGetPos($MainGUI, "", $IStep8ChangeTo)
EndFunc
;~ Chỉnh vị trí của $IStep8ChangeTo
Func IStep8ChangeToSetPos($x = -1,$y = -1)
	Local $Size = IStep8ChangeToGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IStep8ChangeTo,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IStep8ChangeTo
Func IStep8ChangeToSetSize($Width = -1,$Height = -1)
	Local $Size = IStep8ChangeToGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IStep8ChangeTo,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IStep8ChangeTo
Func IStep8ChangeToGetState()
	Return GUICtrlGetState($IStep8ChangeTo)
EndFunc
Func IStep8ChangeToSetState($State = $GUI_SHOW)
	GUICtrlSetState($IStep8ChangeTo,$State)
EndFunc


;~ Chỉnh màu chữ của $IStep8ChangeTo
Func IStep8ChangeToColor($Color = 0x000000)
	GUICtrlSetColor($IStep8ChangeTo,$Color)
EndFunc
;~ Chỉnh màu nền của $IStep8ChangeTo
Func IStep8ChangeToBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IStep8ChangeTo,$Color)
EndFunc