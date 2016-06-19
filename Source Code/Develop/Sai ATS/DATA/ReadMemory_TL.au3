
#include <GUIConstants.au3>
#include <WinAPI.au3>

$PointAdd = 0x1153A39C ;3AC = 1484E330
$PointAdd = 0x115793A0 ;3AC = 1484E330

;~ WinSetTitle("[CLASS:evWin32Wnd]", "","Thuc Son")

$Pid=WinGetProcess("[TITLE:Thien Long Bat Bo; CLASS:TianLongBaBu WndClass]")

$MEMID=_memoryopen($pid)
$Form1 = GUICreate("Thong tin hp va mp", 245, 63, 193, 125)
$Point_Display = GUICtrlCreateLabel("", 68, 0, 164, 28)
GUISetState(@SW_SHOW)


While 1
$ECXPoint = _MemoryRead($PointAdd,$MEMID)
$MPPoint = _MemoryRead($ECXPoint+0x778,$MEMID)

GUICtrlSetData($Point_Display,$MPPoint)
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
Sleep(77)
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