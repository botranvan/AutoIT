;~ Bấm vào $LISensorFuncList
GUICtrlSetOnEvent($LISensorFuncList, "LISensorFuncListClick")
Func LISensorFuncListClick()
;~	MsgBox(0,"72ls.NET","LISensorFuncListClick")
;~	LISensorFuncListSave()
EndFunc

;~ LISensorFuncListTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func LISensorFuncListTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "LISensorFuncList"

	$Text = FT($ControlID,LISensorFuncListGet())

	LISensorFuncListSet($Text)
EndFunc

;Lưu giá trị trong label xuống file
Func LISensorFuncListSave()
	IniWrite($DataFile,"Setting","LISensorFuncList",LISensorFuncListGet())
EndFunc

;Nạp giá trị của label từ file
Func LISensorFuncListLoad()
	Local $Data = IniRead($DataFile,"Setting","LISensorFuncList",LISensorFuncListGet())
	LISensorFuncListSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $LISensorFuncList
Func LISensorFuncListGet()
	Return GUICtrlRead($LISensorFuncList)
EndFunc
;~ Lấy giá trị từ $LISensorFuncList
Func LISensorFuncListSet($NewValue = "")
	Local $Check = LISensorFuncListGet()
	If $Check <> $NewValue Then GUICtrlSetData($LISensorFuncList,$NewValue)
EndFunc
;~ Xóa tất cả giá trị trong $LISensorFuncList
Func LISensorFuncListClear()
	GUICtrlSetData($LISensorFuncList,'')
EndFunc


;~ Lấy vị trí và kích thước của $LISensorFuncList
Func LISensorFuncListGetPos()
	Return ControlGetPos($MainGUI, "", $LISensorFuncList)
EndFunc
;~ Chỉnh vị trí của $LISensorFuncList
Func LISensorFuncListSetPos($x = -1,$y = -1)
	Local $Size = LISensorFuncListGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($LISensorFuncList,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $LISensorFuncList
Func LISensorFuncListSetSize($Width = -1,$Height = -1)
	Local $Size = LISensorFuncListGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($LISensorFuncList,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $LISensorFuncList
Func LISensorFuncListGetState()
	Return GUICtrlGetState($LISensorFuncList)
EndFunc
Func LISensorFuncListSetState($State = $GUI_SHOW)
	GUICtrlSetState($LISensorFuncList,$State)
EndFunc


;~ Chỉnh màu chữ của $LISensorFuncList
Func LISensorFuncListColor($Color = 0x000000)
	GUICtrlSetColor($LISensorFuncList,$Color)
EndFunc
;~ Chỉnh màu nền của $LISensorFuncList
Func LISensorFuncListBackGround($Color = 0x000000)
	GUICtrlSetBkColor($LISensorFuncList,$Color)
EndFunc