;~ Bấm vào $CHRing
GUICtrlSetOnEvent($CHRing, "CHRingClick")
Func CHRingClick()
;~ 	$SpamCount = CHRingIsCheck()
;~ 	MsgBox(0,'',$SpamCount)
EndFunc

;~ CHRingTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func CHRingTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "CHRing"

	$Text = FT($ControlID,CHRingGet())

	CHRingSet($Text)
EndFunc

;Lưu trạng thái của CHRing xuống file
Func CHRingCheckSave()
	IniWrite($DataFile,"Setting","CHRingCheck",CHRingGet(0))
EndFunc

;Nạp trạng thái của CHRing từ file
;~ CHRingCheckLoad()
Func CHRingCheckLoad()
	Local $Data = IniRead($DataFile,"Setting","CHRingCheck",CHRingGet(0))
	CHRingCheck($Data)
EndFunc

;~ Check và UnCheck $CHRing
Func CHRingCheck($check = 0)
	If $check == 1 Then	CHRingSetState($GUI_CHECKED)
	If $check == 4 Then	CHRingSetState($GUI_UNCHECKED)
EndFunc

;~ Kiểm tra xem $CHRing có đang check hay không
Func CHRingIsCheck()
	Local $State = CHRingGet(0)
	If $State == 1 Then	Return True
	If $State == 4 Then	Return False
EndFunc

;Lưu giá trị trong label xuống file
Func CHRingSave()
	IniWrite($DataFile,"Setting","CHRing",CHRingGet())
EndFunc
;Nạp giá trị của label từ file
Func CHRingLoad()
	Local $Data = IniRead($DataFile,"Setting","CHRing",CHRingGet())
	CHRingSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $CHRing
Func CHRingGet($Advanced = 0)
	Return GUICtrlRead($CHRing,$Advanced)
EndFunc
;~ Lấy giá trị từ $CHRing
Func CHRingSet($NewValue = "")
	Local $Check = CHRingGet()
	If $Check <> $NewValue Then GUICtrlSetData($CHRing,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $CHRing
Func CHRingGetPos()
	Return ControlGetPos($MainGUI, "", $CHRing)
EndFunc
;~ Chỉnh vị trí của $CHRing
Func CHRingSetPos($x = -1,$y = -1)
	Local $Size = CHRingGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($CHRing,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $CHRing
Func CHRingSetSize($Width = -1,$Height = -1)
	Local $Size = CHRingGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($CHRing,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $CHRing
Func CHRingGetState()
	Return GUICtrlGetState($CHRing)
EndFunc
Func CHRingSetState($State = $GUI_SHOW)
	GUICtrlSetState($CHRing,$State)
EndFunc


;~ Chỉnh màu chữ của $CHRing
Func CHRingColor($Color = 0x000000)
	GUICtrlSetColor($CHRing,$Color)
EndFunc
;~ Chỉnh màu nền của $CHRing
Func CHRingBackGround($Color = 0x000000)
	GUICtrlSetBkColor($CHRing,$Color)
EndFunc

;~ Chỉnh màu font chữ
Func CHRingFont($Size,$Weight)
	GUICtrlSetFont($CHRing,$Size,$Weight)
EndFunc