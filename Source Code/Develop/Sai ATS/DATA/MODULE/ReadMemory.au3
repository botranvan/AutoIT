  #include <GUIConstants.au3>
Dim $Hp_Curren,$Hp_Max,$Mp_Curren,$Mp_Max

;~ $BaseAdd = 0x128307e8
;~ $BaseAdd = 0x1282fd90
;~ $BaseAdd = 0x12830d70
;~ $BaseAdd = 0x1282feb8

;~ $BaseAdd = 0x14625A80
;~ $BaseAdd = 0x1488D198 ;4A0 = 1488CCF8
;~ $BaseAdd = 0x1484E474 ;144 = 1484E330
$BaseAdd = 0x1485C250 ;404 = 1484E330

;~ WinSetTitle("[CLASS:evWin32Wnd]", "","Thuc Son")

$Pid=WinGetProcess("[TITLE:ThucSon; CLASS:evWin32Wnd]")

$MEMID=_memoryopen($pid)
$Form1 = GUICreate("Thong tin hp va mp", 245, 63, 193, 125)
$Label1 = GUICtrlCreateLabel("Hp", 16, 8, 18, 17)
$Label2 = GUICtrlCreateLabel("Mp", 16, 32, 19, 17)
$Hp_Display = GUICtrlCreateLabel("", 68, 0, 164, 28)
$Mp_Display = GUICtrlCreateLabel("", 72, 32, 164, 20)
GUICtrlSetData($Hp_Display,$Hp_Curren & " / " & $Hp_Max)
GUICtrlSetData($Mp_Display,$Mp_Curren & "/ " & $Mp_Max)
GUISetState(@SW_SHOW)


While 1
$Hp_Curren = _MemoryRead($BaseAdd +0x2e4,$MEMID)
$Hp_Max = _MemoryRead($BaseAdd +0x20,$MEMID)
$Mp_Curren = _MemoryRead($BaseAdd + 0x2e8,$MEMID)
$Mp_Max = _MemoryRead($BaseAdd +0x290,$MEMID)
GUICtrlSetData($Hp_Display,$Hp_Curren & " / " & $Hp_Max)
GUICtrlSetData($Mp_Display,$Mp_Curren & "/ " & $Mp_Max)
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd

Func _MemoryOpen($iv_Pid, $iv_DesiredAccess = 0x1F0FFF, $iv_InheritHandle = 1)
	
	If Not ProcessExists($iv_Pid) Then
		SetError(1)
        Return 0
	EndIf
	
	Local $ah_Handle[2] = [DllOpen('kernel32.dll')]
	
	If @Error Then
        SetError(2)
        Return 0
    EndIf
	
	Local $av_OpenProcess = DllCall($ah_Handle[0], 'int', 'OpenProcess', 'int', $iv_DesiredAccess, 'int', $iv_InheritHandle, 'int', $iv_Pid)
	
	If @Error Then
        DllClose($ah_Handle[0])
        SetError(3)
        Return 0
    EndIf
	
	$ah_Handle[1] = $av_OpenProcess[0]
	
	Return $ah_Handle
	
EndFunc

Func _MemoryRead($iv_Address, $ah_Handle, $sv_Type = 'dword')
	
	If Not IsArray($ah_Handle) Then
		SetError(1)
        Return 0
	EndIf
	
	Local $v_Buffer = DllStructCreate($sv_Type)
	
	If @Error Then
		SetError(@Error + 1)
		Return 0
	EndIf
	
	DllCall($ah_Handle[0], 'int', 'ReadProcessMemory', 'int', $ah_Handle[1], 'int', $iv_Address, 'ptr', DllStructGetPtr($v_Buffer), 'int', DllStructGetSize($v_Buffer), 'int', '')
	
	If Not @Error Then
		Local $v_Value = DllStructGetData($v_Buffer, 1)
		Return $v_Value
	Else
		SetError(6)
        Return 0
	EndIf
	
EndFunc