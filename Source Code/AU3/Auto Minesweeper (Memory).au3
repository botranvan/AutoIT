;creat by chocolate_buon
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
Opt("MouseClickDelay", 0)
Opt("MouseClickDownDelay", 0)
Opt("GUIOnEventMode", 0)

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

Func _MemoryClose($ah_Handle)

	If Not IsArray($ah_Handle) Then
		SetError(1)
		Return 0
	EndIf

	DllCall($ah_Handle[0], 'int', 'CloseHandle', 'int', $ah_Handle[1])
	If Not @error Then
		DllClose($ah_Handle[0])
		Return 1
	Else
		DllClose($ah_Handle[0])
		SetError(2)
		Return 0
	EndIf

EndFunc
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Auto play", 177, 55, 635, 507)
$Button1 = GUICtrlCreateButton("Open game", 8, 16, 73, 25, $WS_GROUP)
$Button2 = GUICtrlCreateButton("Play", 95, 18, 73, 25, $WS_GROUP)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
Dim Const $sClass = "[Class:Minesweeper]" ;;neu la phien ban tieng anh thi thay o day
Dim $MEMID,$PID
Dim $aMin[16]
$aMin[0] = 0x01005361
for $i= 1 to 15
	$aMin[$i] = $aMin[0]  + $i * 0x20
Next


Func RunGame()
	If WinExists($sClass) Then
		$hWnd = WinGetHandle($sClass)
		$PID = WinGetProcess($hWnd)
	Else
		$PID = Run("winmine")
		$hWnd = WinGetHandle($sClass)
	EndIf
	$MEMID = _MemoryOpen($PID)
EndFunc
Func Play()
	$min = _MemoryRead(0x1005194,$MEMID,"dword")
	for $i = 0 to 15
		for $j = 0 to 30
			$Curent = _MemoryRead( $aMin[$i] + $j ,$MEMID,"byte")
				;MsgBox(0,"",$Curent & "  " & hex($aMin[$i] + $j) )
			if $Curent = 15 Then
				ControlClick($sClass,"","","left",1,20 + $j * 16,60 + $i*16)
			Else
				ControlClick($sClass,"","","right",1,20 + $j * 16,60 + $i*16)
			EndIf
		Next
	Next
EndFunc

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
			_MemoryClose($PID)
		Case $Button1
			RunGame()
		Case $Button2
			Play()
	EndSwitch
	Sleep(100)
WEnd

