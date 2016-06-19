;~ Bấm vào $BStep7Restore
GUICtrlSetOnEvent($BStep7Restore, "BStep7RestoreClick")
Func BStep7RestoreClick()
	FCTStep7Restore()
;~ 	MsgBox(0,'BStep7RestoreClick','')
EndFunc


;~ BStep7RestoreTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func BStep7RestoreTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "BStep7Restore"

	$Text = FT($ControlID,BStep7RestoreGet())

	BStep7RestoreSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func BStep7RestoreSave()
	IniWrite($DataFile,"Setting","BStep7Restore",BStep7RestoreGet())
EndFunc

;Nạp giá trị của label từ file
Func BStep7RestoreLoad()
	Local $Data = IniRead($DataFile,"Setting","BStep7Restore",BStep7RestoreGet())
	BStep7RestoreSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $BStep7Restore
Func BStep7RestoreGet()
	Return GUICtrlRead($BStep7Restore)
EndFunc
;~ Lấy giá trị từ $BStep7Restore
Func BStep7RestoreSet($NewValue = "")
	Local $Check = BStep7RestoreGet()
	If $Check <> $NewValue Then GUICtrlSetData($BStep7Restore,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $BStep7Restore
Func BStep7RestoreGetPos()
	Return ControlGetPos($MainGUI, "", $BStep7Restore)
EndFunc
;~ Chỉnh vị trí của $BStep7Restore
Func BStep7RestoreSetPos($x = -1,$y = -1)
	Local $Size = BStep7RestoreGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($BStep7Restore,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $BStep7Restore
Func BStep7RestoreSetSize($Width = -1,$Height = -1)
	Local $Size = BStep7RestoreGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($BStep7Restore,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $BStep7Restore
Func BStep7RestoreGetState()
	Return GUICtrlGetState($BStep7Restore)
EndFunc
Func BStep7RestoreSetState($State = $GUI_SHOW)
	GUICtrlSetState($BStep7Restore,$State)
EndFunc


;~ Chỉnh màu chữ của $BStep7Restore
Func BStep7RestoreColor($Color = 0x000000)
	GUICtrlSetColor($BStep7Restore,$Color)
EndFunc
;~ Chỉnh màu nền của $BStep7Restore
Func BStep7RestoreBackGround($Color = 0x000000)
	GUICtrlSetBkColor($BStep7Restore,$Color)
EndFunc