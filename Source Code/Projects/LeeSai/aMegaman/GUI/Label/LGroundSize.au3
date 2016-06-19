;~ Bấm vào $LGroundSize
GUICtrlSetOnEvent($LGroundSize, "LGroundSizeClick")
Func LGroundSizeClick()
;~	MsgBox(0,"72ls.NET","LGroundSizeClick")
EndFunc

;~ LGroundSizeTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func LGroundSizeTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "LGroundSize"

 	$Text = FT($ControlID,LGroundSizeGet())

	LGroundSizeSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func LGroundSizeSave()
	IniWrite($DataFile,"Setting","LGroundSize",LGroundSizeGet())
EndFunc

;Nạp giá trị của label từ file
Func LGroundSizeLoad()
	Local $Data = IniRead($DataFile,"Setting","LGroundSize",LGroundSizeGet())
	LGroundSizeSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $LGroundSize
Func LGroundSizeGet()
	Return GUICtrlRead($LGroundSize)
EndFunc
;~ Lấy giá trị từ $LGroundSize
Func LGroundSizeSet($NewValue = "")
	Local $Check = LGroundSizeGet()
	If $Check <> $NewValue Then GUICtrlSetData($LGroundSize,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $LGroundSize
Func LGroundSizeGetPos()
	Return ControlGetPos($MainGUI, "", $LGroundSize)
EndFunc
;~ Chỉnh vị trí của $LGroundSize
Func LGroundSizeSetPos($x = -1,$y = -1)
	Local $Size = LGroundSizeGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LGroundSize,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LGroundSize
Func LGroundSizeSetSize($Width = -1,$Height = -1)
	Local $Size = LGroundSizeGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LGroundSize,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LGroundSize
Func LGroundSizeGetState()
	Return GUICtrlGetState($LGroundSize)
EndFunc
Func LGroundSizeSetState($State = $GUI_SHOW)
	GUICtrlSetState($LGroundSize,$State)
EndFunc


;~ Chỉnh màu chữ của $LGroundSize
Func LGroundSizeColor($Color = 0x000000)
	GUICtrlSetColor($LGroundSize,$Color)
EndFunc
;~ Chỉnh màu nền của $LGroundSize
Func LGroundSizeBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LGroundSize,$Color)
EndFunc