;~ Bấm vào $CHIndex
GUICtrlSetOnEvent($CHIndex, "CHIndexClick")
Func CHIndexClick()
;~ 	$SpamCount = CHIndexIsCheck()
;~ 	MsgBox(0,'',$SpamCount)
EndFunc

;~ CHIndexTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func CHIndexTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "CHIndex"

	$Text = FT($ControlID,CHIndexGet())

	CHIndexSet($Text)
EndFunc

;Lưu trạng thái của CHIndex xuống file
Func CHIndexCheckSave()
	IniWrite($DataFile,"Setting","CHIndexCheck",CHIndexGet(0))
EndFunc

;Nạp trạng thái của CHIndex từ file
;~ CHIndexCheckLoad()
Func CHIndexCheckLoad()
	Local $Data = IniRead($DataFile,"Setting","CHIndexCheck",CHIndexGet(0))
	CHIndexCheck($Data)
EndFunc

;~ Check và UnCheck $CHIndex
Func CHIndexCheck($check = 0)
	If $check == 1 Then	CHIndexSetState($GUI_CHECKED)
	If $check == 4 Then	CHIndexSetState($GUI_UNCHECKED)
EndFunc

;~ Kiểm tra xem $CHIndex có đang check hay không
Func CHIndexIsCheck()
	Local $State = CHIndexGet(0)
	If $State == 1 Then	Return True
	If $State == 4 Then	Return False
EndFunc

;Lưu giá trị trong label xuống file
Func CHIndexSave()
	IniWrite($DataFile,"Setting","CHIndex",CHIndexGet())
EndFunc
;Nạp giá trị của label từ file
Func CHIndexLoad()
	Local $Data = IniRead($DataFile,"Setting","CHIndex",CHIndexGet())
	CHIndexSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $CHIndex
Func CHIndexGet($Advanced = 0)
	Return GUICtrlRead($CHIndex,$Advanced)
EndFunc
;~ Lấy giá trị từ $CHIndex
Func CHIndexSet($NewValue = "")
	Local $Check = CHIndexGet()
	If $Check <> $NewValue Then GUICtrlSetData($CHIndex,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $CHIndex
Func CHIndexGetPos()
	Return ControlGetPos($MainGUI, "", $CHIndex)
EndFunc
;~ Chỉnh vị trí của $CHIndex
Func CHIndexSetPos($x = -1,$y = -1)
	Local $Size = CHIndexGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($CHIndex,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $CHIndex
Func CHIndexSetSize($Width = -1,$Height = -1)
	Local $Size = CHIndexGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($CHIndex,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $CHIndex
Func CHIndexGetState()
	Return GUICtrlGetState($CHIndex)
EndFunc
Func CHIndexSetState($State = $GUI_SHOW)
	GUICtrlSetState($CHIndex,$State)
EndFunc


;~ Chỉnh màu chữ của $CHIndex
Func CHIndexColor($Color = 0x000000)
	GUICtrlSetColor($CHIndex,$Color)
EndFunc
;~ Chỉnh màu nền của $CHIndex
Func CHIndexBackGround($Color = 0x000000)
	GUICtrlSetBkColor($CHIndex,$Color)
EndFunc

;~ Chỉnh màu font chữ
Func CHIndexFont($Size,$Weight)
	GUICtrlSetFont($CHIndex,$Size,$Weight)
EndFunc