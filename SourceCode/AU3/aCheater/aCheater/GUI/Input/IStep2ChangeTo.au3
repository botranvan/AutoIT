;~ Bấm vào $IStep2ChangeTo
GUICtrlSetOnEvent($IStep2ChangeTo, "IStep2ChangeToChange")
Func IStep2ChangeToChange()
;~	MsgBox(0,"72ls.NET","IStep2ChangeToChange")
	IStep2ChangeToSave()
EndFunc

;~ IStep2ChangeToTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func IStep2ChangeToTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "IStep2ChangeTo"

	$Text = FT($ControlID,IStep2ChangeToGet())

	IStep2ChangeToSet($Text)
EndFunc

;~ Lưu chuỗi ngôn ngữ của 1 control
Func IStep2ChangeToTSave()
    FTWrite('IStep2ChangeTo',IStep2ChangeToGet())
EndFunc

;Lưu giá trị trong label xuống file
Func IStep2ChangeToSave()
	IniWrite($DataFile,"Setting","IStep2ChangeTo",IStep2ChangeToGet())
EndFunc

;Nạp giá trị của label từ file
IStep2ChangeToLoad()
Func IStep2ChangeToLoad()
	Local $Data = IniRead($DataFile,"Setting","IStep2ChangeTo",IStep2ChangeToGet())
	IStep2ChangeToSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $IStep2ChangeTo
Func IStep2ChangeToGet()
	Return GUICtrlRead($IStep2ChangeTo)
EndFunc
;~ Lấy giá trị từ $IStep2ChangeTo
Func IStep2ChangeToSet($NewValue = "")
	Local $Check = IStep2ChangeToGet()
	If $Check <> $NewValue Then GUICtrlSetData($IStep2ChangeTo,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $IStep2ChangeTo
Func IStep2ChangeToGetPos()
	Return ControlGetPos($MainGUI, "", $IStep2ChangeTo)
EndFunc
;~ Chỉnh vị trí của $IStep2ChangeTo
Func IStep2ChangeToSetPos($x = -1,$y = -1)
	Local $Size = IStep2ChangeToGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($IStep2ChangeTo,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $IStep2ChangeTo
Func IStep2ChangeToSetSize($Width = -1,$Height = -1)
	Local $Size = IStep2ChangeToGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($IStep2ChangeTo,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $IStep2ChangeTo
Func IStep2ChangeToGetState()
	Return GUICtrlGetState($IStep2ChangeTo)
EndFunc
Func IStep2ChangeToSetState($State = $GUI_SHOW)
	GUICtrlSetState($IStep2ChangeTo,$State)
EndFunc


;~ Chỉnh màu chữ của $IStep2ChangeTo
Func IStep2ChangeToColor($Color = 0x000000)
	GUICtrlSetColor($IStep2ChangeTo,$Color)
EndFunc
;~ Chỉnh màu nền của $IStep2ChangeTo
Func IStep2ChangeToBackGround($Color = 0x000000)
	GUICtrlSetBkColor($IStep2ChangeTo,$Color)
EndFunc