#include-once

Global Const $WH_MOUSE_LL 					= 14

Global Const $MOUSE_MOVE_EVENT				= 512
Global Const $MOUSE_PRIMARYDOWN_EVENT		= 513
Global Const $MOUSE_PRIMARYUP_EVENT			= 514
Global Const $MOUSE_SECONDARYDOWN_EVENT		= 516
Global Const $MOUSE_SECONDARYUP_EVENT		= 517
Global Const $MOUSE_WHELLDOWN_EVENT			= 519
Global Const $MOUSE_WHELLUP_EVENT			= 520
Global Const $MOUSE_WHELLSCROLL_EVENT		= 522
Global Const $MOUSE_EXTRABUTTONDOWN_EVENT	= 523
Global Const $MOUSE_EXTRABUTTONUP_EVENT		= 524

Global $hKey_Proc 							= -1
Global $hM_Module 							= -1
Global $hM_Hook 							= -1
Global $aMouse_Events[1][1]

Func OnAutoItExit()
	If IsArray($hM_Hook) And $hM_Hook[0] > 0 Then
		DllCall("user32.dll", "int", "UnhookWindowsHookEx", "hwnd", $hM_Hook[0])
		$hM_Hook[0] = 0
	EndIf
	
	If IsPtr($hKey_Proc) Then
		DllCallbackFree($hKey_Proc)
		$hKey_Proc = 0
	EndIf
EndFunc

Func _MouseSetOnEvent($iEvent, $sFuncName="", $sParam1="", $sParam2="", $hTargetWnd=0, $iBlockDefProc=1)
	If $sFuncName = "" Then ;Unset Event
		If $aMouse_Events[0][0] < 1 Then Return 0
		Local $aTmp_Mouse_Events[1][1]
		
		For $i = 1 To $aMouse_Events[0][0]
			If $aMouse_Events[$i][0] <> $iEvent Then
				$aTmp_Mouse_Events[0][0] += 1
				ReDim $aTmp_Mouse_Events[$aTmp_Mouse_Events[0][0]+1][6]
				$aTmp_Mouse_Events[$aTmp_Mouse_Events[0][0]][0] = $aMouse_Events[$i][0]
				$aTmp_Mouse_Events[$aTmp_Mouse_Events[0][0]][1] = $aMouse_Events[$i][1]
				$aTmp_Mouse_Events[$aTmp_Mouse_Events[0][0]][2] = $aMouse_Events[$i][2]
				$aTmp_Mouse_Events[$aTmp_Mouse_Events[0][0]][3] = $aMouse_Events[$i][3]
				$aTmp_Mouse_Events[$aTmp_Mouse_Events[0][0]][4] = $aMouse_Events[$i][4]
				$aTmp_Mouse_Events[$aTmp_Mouse_Events[0][0]][5] = $aMouse_Events[$i][5]
			EndIf
		Next
		
		$aMouse_Events = $aTmp_Mouse_Events
		
		If $aMouse_Events[0][0] < 1 Then OnAutoItExit()
		
		Return 1
	EndIf
	
	If $aMouse_Events[0][0] < 1 Then
		$hKey_Proc 	= DllCallbackRegister("_Mouse_Events_Handler", "int", "int;ptr;ptr")
		$hM_Module 	= DllCall("kernel32.dll", "hwnd", "GetModuleHandle", "ptr", 0)
		$hM_Hook 	= DllCall("user32.dll", "hwnd", "SetWindowsHookEx", "int", $WH_MOUSE_LL, _
			"ptr", DllCallbackGetPtr($hKey_Proc), "hwnd", $hM_Module[0], "dword", 0)
	EndIf
	
	$aMouse_Events[0][0] += 1
	ReDim $aMouse_Events[$aMouse_Events[0][0]+1][6]
	$aMouse_Events[$aMouse_Events[0][0]][0] = $iEvent
	$aMouse_Events[$aMouse_Events[0][0]][1] = $sFuncName
	$aMouse_Events[$aMouse_Events[0][0]][2] = $sParam1
	$aMouse_Events[$aMouse_Events[0][0]][3] = $sParam2
	$aMouse_Events[$aMouse_Events[0][0]][4] = $hTargetWnd
	$aMouse_Events[$aMouse_Events[0][0]][5] = $iBlockDefProc
EndFunc

Func _Mouse_Events_Handler($nCode, $wParam, $lParam)
	Local $iEvent = BitAND($wParam, 0xFFFF)
	
	If $aMouse_Events[0][0] < 1 Then
		OnAutoItExit()
		Return 0
	EndIf
	
	For $i = 1 To $aMouse_Events[0][0]
		If $aMouse_Events[$i][0] = $iEvent Then
			If $aMouse_Events[$i][4] <> 0 And Not _IsHoveredWnd($aMouse_Events[$i][4]) Then Return 0 ;Allow default processing
			Local $sExec = "Call($aMouse_Events[$i][1]"
			
			For $j = 2 To 3
				If $aMouse_Events[$i][$j] <> "" Then $sExec &= ", " & $aMouse_Events[$i][$j]
			Next
			
			$sExec &= ")"
			
			$iRet = Execute($sExec)
			
			If $aMouse_Events[$i][5] = -1 Then Return $iRet
			Return $aMouse_Events[$i][5] ;Block default processing (or not :))
		EndIf
	Next
EndFunc

Func _IsHoveredWnd($hWnd)
	Local $iRet = False
	Local $aWin_Pos = WinGetPos($hWnd)
	Local $aMouse_Pos = MouseGetPos()
	
	If $aMouse_Pos[0] >= $aWin_Pos[0] And $aMouse_Pos[0] <= ($aWin_Pos[0] + $aWin_Pos[2]) And _
		$aMouse_Pos[1] >= $aWin_Pos[1] And $aMouse_Pos[1] <= ($aWin_Pos[1] + $aWin_Pos[3]) Then $iRet = True
	
	Local $aRet = DllCall("user32.dll", "int", "WindowFromPoint", _
		"long", $aMouse_Pos[0], _
		"long", $aMouse_Pos[1])
	
	If Not WinActive($hWnd) Or ($aRet[0] <> $hWnd And Not $iRet) Then $iRet = False
	
	Return $iRet
EndFunc
