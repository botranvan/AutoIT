;~ Bấm vào $CHStep8Freeze
GUICtrlSetOnEvent($CHStep8Freeze, "CHStep8FreezeClick")
Func CHStep8FreezeClick()
;~ 	$SpamCount = CHStep8FreezeIsCheck()
;~ 	MsgBox(0,'',$SpamCount)
EndFunc

CHStep8FreezeTLoad()
;~ Nạp chuỗi ngôn ngữ của 1 control
Func CHStep8FreezeTLoad($ControlID = "")
    Local $Line,$Text,$File
	If $ControlID=="" Then $ControlID = "CHStep8Freeze"

	$Text = FT($ControlID,CHStep8FreezeGet())

	CHStep8FreezeSet($Text)
EndFunc

;Lưu trạng thái của CHStep8Freeze xuống file
Func CHStep8FreezeCheckSave()
	IniWrite($DataFile,"Setting","CHStep8FreezeCheck",CHStep8FreezeGet(0))
EndFunc

;Nạp trạng thái của CHStep8Freeze từ file
;~ CHStep8FreezeCheckLoad()
Func CHStep8FreezeCheckLoad()
	Local $Data = IniRead($DataFile,"Setting","CHStep8FreezeCheck",CHStep8FreezeGet(0))
	CHStep8FreezeCheck($Data)
EndFunc

;~ Check và UnCheck $CHStep8Freeze
Func CHStep8FreezeCheck($check = 0)
	If $check == 1 Then	CHStep8FreezeSetState($GUI_CHECKED)
	If $check == 4 Then	CHStep8FreezeSetState($GUI_UNCHECKED)
EndFunc

;~ Kiểm tra xem $CHStep8Freeze có đang check hay không
Func CHStep8FreezeIsCheck()
	Local $State = CHStep8FreezeGet(0)
	If $State == 1 Then	Return True
	If $State == 4 Then	Return False
EndFunc

;Lưu giá trị trong label xuống file
Func CHStep8FreezeSave()
	IniWrite($DataFile,"Setting","CHStep8Freeze",CHStep8FreezeGet())
EndFunc
;Nạp giá trị của label từ file
Func CHStep8FreezeLoad()
	Local $Data = IniRead($DataFile,"Setting","CHStep8Freeze",CHStep8FreezeGet())
	CHStep8FreezeSet($Data)
EndFunc

;~ Chỉnh giá trị chuỗi của $CHStep8Freeze
Func CHStep8FreezeGet($Advanced = 0)
	Return GUICtrlRead($CHStep8Freeze,$Advanced)
EndFunc
;~ Lấy giá trị từ $CHStep8Freeze
Func CHStep8FreezeSet($NewValue = "")
	Local $Check = CHStep8FreezeGet()
	If $Check <> $NewValue Then GUICtrlSetData($CHStep8Freeze,$NewValue)
EndFunc


;~ Lấy vị trí và kích thước của $CHStep8Freeze
Func CHStep8FreezeGetPos()
	Return ControlGetPos($MainGUI, "", $CHStep8Freeze)
EndFunc
;~ Chỉnh vị trí của $CHStep8Freeze
Func CHStep8FreezeSetPos($x = -1,$y = -1)
	Local $Size = CHStep8FreezeGetPos()
	If Not ($x == -1) Then $Size[0] = $x
	If Not ($y == -1) Then $Size[1] = $y
	GUICtrlSetPos($CHStep8Freeze,$Size[0],$Size[1])
EndFunc
;~ Chỉnh kích thước của $CHStep8Freeze
Func CHStep8FreezeSetSize($Width = -1,$Height = -1)
	Local $Size = CHStep8FreezeGetPos()
	If Not ($Width == -1) Then $Size[2] = $Width
	If Not ($Height == -1) Then $Size[3] = $Height
	GUICtrlSetPos($CHStep8Freeze,$Size[0],$Size[1],$Size[2],$Size[3])
EndFunc


;~ Chỉnh trạng thái $CHStep8Freeze
Func CHStep8FreezeGetState()
	Return GUICtrlGetState($CHStep8Freeze)
EndFunc
Func CHStep8FreezeSetState($State = $GUI_SHOW)
	GUICtrlSetState($CHStep8Freeze,$State)
EndFunc


;~ Chỉnh màu chữ của $CHStep8Freeze
Func CHStep8FreezeColor($Color = 0x000000)
	GUICtrlSetColor($CHStep8Freeze,$Color)
EndFunc
;~ Chỉnh màu nền của $CHStep8Freeze
Func CHStep8FreezeBackGround($Color = 0x000000)
	GUICtrlSetBkColor($CHStep8Freeze,$Color)
EndFunc

;~ Chỉnh màu font chữ
Func CHStep8FreezeFont($Size,$Weight)
	GUICtrlSetFont($CHStep8Freeze,$Size,$Weight)
EndFunc