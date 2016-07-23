#include-once
#include <WinAPI.au3>
#include <GDIPlus.au3>

;Opt("MustDeclareVars", 1)

; #CURRENT# =====================================================================================================================
;           _IconDock_BeginUpdate
;           _IconDock_Create
;           _IconDock_Destroy
;           _IconDock_EndUpdate
;           _IconDock_Fade
;           _IconDock_GetBitmapFromHIcon
;           _IconDock_GetPos
;           _IconDock_IconAdd
;           _IconDock_IconAddFile
;           _IconDock_IconCalcNonCollisionPosition
;           _IconDock_IconGetActive
;           _IconDock_IconGetBitmap
;           _IconDock_IconRemove
;           _IconDock_IconSetBitmap
;           _IconDock_IconSetIcon
;           _IconDock_IconSetIndex
;           _IconDock_IconSetPos
;           _IconDock_SetAlpha
;           _IconDock_SetOnActiveChange
;           _IconDock_SetOffset
;           _IconDock_SetPos
;           _IconDock_SetShadowOffset
;           _IconDock_SetIconSize
; ===============================================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================================
;           __IconDock_CalcJump
;           __IconDock_CalcOffset
;           __IconDock_CalcOriginalPositions
;           __IconDock_CalcOriginalPositionsFree
;           __IconDock_CalcPos
;           __IconDock_CalcPosFreeSideStep
;           __IconDock_CalcSize
;           __IconDock_Calculations
;           __IconDock_DrawIcons
;           __IconDock_DrawShadow
;           __IconDock_DrawText
;           __IconDock_FreeSideStep
;           __IconDock_GetIndex
;           __IconDock_IconToGdiPlus
;           __IconDock_MouseProc
;           __IconDock_MsgProc
;           __IconDock_NoActivate
;           __IconDock_OnExitFunc
;           __IconDock_RemoveIcon
;           __IconDock_Scroll
;           __IconDock_SetIndex
;           __IconDock_StartCalcAndDraw
;           __IconDock_StartJump
;           __IconDock_SwitchIndex
;           __IconDock_TimerProc
;           __IconDock_TrackMouseEvent
;           __IconDock_WinEventProc
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
; IconDock constants
; ===============================================================================================================================
Global Const $IconDock_Align_Free = 0x0000
Global Const $IconDock_Align_Horizontal = 0x0001
Global Const $IconDock_Align_Vertical = 0x0002

Global Const $IconDock_Center = 0x0004
Global Const $IconDock_Left = 0x0008
Global Const $IconDock_Right = 0x0010
Global Const $IconDock_Up = 0x0020
Global Const $IconDock_Down = 0x0040

Global Const $IconDock_LBUTTONDOWN = 0x0001
Global Const $IconDock_LBUTTONUP = 0x0002
Global Const $IconDock_LBUTTONDBLCLK = 0x0004
Global Const $IconDock_RBUTTONDOWN = 0x0008
Global Const $IconDock_RBUTTONUP = 0x0010
Global Const $IconDock_RBUTTONDBLCLK = 0x0020
Global Const $IconDock_MBUTTONDOWN = 0x0040
Global Const $IconDock_MBUTTONUP = 0x0080
Global Const $IconDock_MBUTTONDBLCLK = 0x0100

; #INTERNAL_VARIABLES#===========================================================================================================
; variables for internal use
; ===============================================================================================================================
Global $s__IconDock = ""
Global $a__IconDock[1][22] = [[0]]
Global $h__IconDock_MsgHook = -1
Global $h__IconDock_MsgProc = -1
Global $h__IconDock_MouseHook = -1
Global $h__IconDock_MouseProc = -1
Global $h__IconDock_EventHook = -1
Global $h__IconDock_EventProc = -1
Global $p__IconDock_TimerProc = DllCallbackRegister("__IconDock_TimerProc", "none", "hwnd;int;uint_ptr;dword")
Global $i__IconDock_UniqueMsg = _WinAPI_RegisterWindowMessage("IconDock")

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_BeginUpdate()
; Description ...: Do not repaint until _IconDock_EndUpdate is called
; Syntax ........: _IconDock_BeginUpdate($hIconDock)
; Parameters ....: $hIconDock - Handle as returned by _IconDock_Create
; Return values .: Success - True
;                  Failure - False and set @error to 1
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......: _IconDock_EndUpdate
; Example .......:
; =================================================================================================
Func _IconDock_BeginUpdate($hIconDock)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)
	$a__IconDock[$iIndex][10] = False
	DllCall("user32.dll", "int", "KillTimer", "hwnd", $hIconDock, "uint_ptr", $a__IconDock[$iIndex][15])
	$a__IconDock[$iIndex][15] = -1
	Return True
EndFunc   ;==>_IconDock_BeginUpdate

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_Create()
; Description ...: Creates an IconDock
; Syntax ........: _IconDock_Create($iX, $iY[, $iW = 0[, $iH = 0[, $iAlign = 5[, $iIconDirection = 32[, $iIconSizeMin = 32[, $iIconSizeMax = 64[, $bSideStep = True[, $hParent = 0[, $iAnimate = 1]]]]]]]]])
; Parameters ....: $iX             - X Position
;                  $iY             - Y Position
;                  $iW             - Width; if 0 then it´s set automatically (depending of alignment and size of parent window)
;                  $iH             - Height; if 0 then it´s set automatically (depending of alignment and size of parent window)
;                  $iAlign         - Alignment
;                                      - one of the following values:
;                                          - $IconDock_Align_Free       - free icon positioning
;
;                                          - $IconDock_Align_Horizontal - horizontal IconDock, Icons are automatically aligned
;                                              - combine (BitOr) with one of the following values:
;                                                  - $IconDock_Center   - align Icons to the center of the IconDock
;                                                  - $IconDock_Left     - align Icons to the left side of the IconDock
;                                                  - $IconDock_Right    - align Icons to the right side of the IconDock
;                                                    Up / Down alignment depends on the $iIconDirection parameter
;
;                                          - $IconDock_Align_Vertical   - vertical IconDock, Icons are automatically aligned
;                                              - combine (BitOr) with one of the following values:
;                                                  - $IconDock_Center   - align Icons to the center of the IconDock
;                                                  - $IconDock_Up       - align Icons to the top of the IconDock
;                                                  - $IconDock_Down     - align Icons to the bottom of the IconDock
;                                                    Left / Right alignment depends on the $iIconDirection parameter
;
;                  $iIconDirection - the way the icons increase
;                                      - combination of one or more of the following values:
;                                          - $IconDock_Center   - the center of the icons remains unchanged
;                                                                   if $IconDock_Align_Vertical: align icons to the horizontal center of the IconDock
;                                                                   if $IconDock_Align_Horizontal: align icons to the vertical center of the IconDock
;                                          - $IconDock_Left     - Icons will grow to the left
;                                                                   if $IconDock_Align_Vertical: align icons to the right side of the IconDock
;                                          - $IconDock_Right    - Icons will grow to the right
;                                                                   if $IconDock_Align_Vertical: align icons to the left side of the IconDock
;                                          - $IconDock_Up       - Icons will grow to the top
;                                                                   if $IconDock_Align_Horizontal: align icons to the bottom of the IconDock
;                                          - $IconDock_Down     - Icons will grow to the bottom
;                                                                   if $IconDock_Align_Horizontal: align icons to the top of the IconDock
;
;                  $iIconSizeMin   - default size of the icons
;                  $iIconSizeMax   - size of the icons on hover
;                  $bSideStep      - if True: Icons do not overlap if some icons increases
;                  $hParent        - handle to the parent window, set to 0 to set the Desktop as parent
; Return values .: Success: return IconDock handle
;                  Failure: return False and sets @error to 1
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_Create($iX, $iY, $iW = 0, $iH = 0, $iAlign = 5, $iIconDirection = 32, $iIconSizeMin = 32, $iIconSizeMax = 64, $bSideStep = True, $hParent = 0)
	Local $hLastCreatedGui = 0
	Local $hDummy = GUICtrlCreateLabel("", 0, 0)
	If Not @error Then
		Local $hWnd = _WinAPI_GetParent(GUICtrlGetHandle($hDummy))
		GUICtrlDelete($hDummy)
		If $hWnd Then $hLastCreatedGui = $hWnd
	EndIf

	If $iW <= 0 Then
		Switch BitAND($iAlign, $IconDock_Align_Vertical)
			Case True
				$iW = $iIconSizeMax + $iIconSizeMin ; MaxSize + Jumpheight
			Case Else
				Switch $hParent
					Case True
						$iW = _WinAPI_GetClientWidth($hParent)
						If @error Or Not $iW Then ContinueCase
					Case 0
						$iW = @DesktopWidth
				EndSwitch
		EndSwitch
	EndIf
	If $iH <= 0 Then
		Switch BitAND($iAlign, $IconDock_Align_Horizontal)
			Case True
				$iH = $iIconSizeMax + $iIconSizeMin ; MaxSize + Jumpheight
			Case Else
				Switch $hParent
					Case True
						$iH = _WinAPI_GetClientHeight($hParent)
						If @error Or Not $iH Then ContinueCase
					Case 0
						$iH = @DesktopHeight
				EndSwitch
		EndSwitch
	EndIf

	Local $iIndex = $a__IconDock[0][0] + 1
	ReDim $a__IconDock[$iIndex + 1][22]
	$a__IconDock[0][0] = $iIndex

	Local $aIcons[1][12] = [[0]]
	Local $aJump[1][7]
	Local $aWindow[10]
	Local $aValues[16]

	Local $bOnTop = False
	Local $iEX_Style = BitOR(0x00080000, 0x00000080, 0x08000000); $WS_EX_LAYERED, $WS_EX_TOOLWINDOW, $WS_EX_NOACTIVATE
	If $hParent Then
		$iEX_Style = BitOR($iEX_Style, 0x00000040); $WS_EX_MDICHILD
	Else
		$iEX_Style = BitOR($iEX_Style, 0x00000008); $WS_EX_TOPMOST
		$bOnTop = True
	EndIf

	Local $hWnd_Icon = GUICreate("IconDock_I Instance " & $iIndex, $iW, $iH, $iX, $iY, 0x80000000, $iEX_Style, $hParent); $WS_POPUP

	Local $tPoint = DllStructCreate("int X;int Y")
	DllStructSetData($tPoint, 1, $iX)
	DllStructSetData($tPoint, 2, $iY)
	_WinAPI_ClientToScreen($hWnd_Icon, $tPoint)

	$aWindow[1] = $hWnd_Icon
	$aWindow[2] = $hParent
	$aWindow[3] = $bOnTop
	$aWindow[4] = DllStructGetData($tPoint, 1)
	$aWindow[5] = DllStructGetData($tPoint, 2)
	$aWindow[6] = $iW
	$aWindow[7] = $iH
	$aWindow[8] = 1 ; Alpha Icon
	$aWindow[9] = 0 ; Alpha Shadow

	_GDIPlus_Startup()
	$aValues[1] = $iAlign
	$aValues[2] = $iIconDirection
	$aValues[3] = $bSideStep
	$aValues[4] = $iIconSizeMin * 2;Thrshld
	$aValues[5] = 20 ; Updatetime
	$aValues[6] = _GDIPlus_BrushCreateSolid(0xFF332211)
	$aValues[7] = _GDIPlus_StringFormatCreate()
	$aValues[8] = _GDIPlus_FontFamilyCreate("Arial")
	$aValues[9] = _GDIPlus_FontCreate($aValues[8], $iIconSizeMin * 0.22, 1)
	$aValues[10] = _GDIPlus_RectFCreate(0, 0, 0, 0)
	$aValues[11] = -0.08
	$aValues[12] = -0.12
	$aValues[13] = 0 ; optional Icon offset
	If @DesktopDepth < 32 Then
		$aValues[14] = _GDIPlus_BrushCreateSolid(0x04010000)
	Else
		$aValues[14] = _GDIPlus_BrushCreateSolid(0x01010000)
	EndIf
	$aValues[15] = $iIconSizeMax

	$aJump[0][4] = 800
	$aJump[0][5] = 4000

	$a__IconDock[0][1] &= "|" & String($hWnd_Icon)
	$a__IconDock[$iIndex][0] = $aIcons
	$a__IconDock[$iIndex][1] = $aJump
	$a__IconDock[$iIndex][2] = $aWindow
	$a__IconDock[$iIndex][3] = $aValues
	$a__IconDock[$iIndex][8] = $iIconSizeMin
	$a__IconDock[$iIndex][9] = $iIconSizeMax
	$a__IconDock[$iIndex][10] = True ; Calc and Draw (Not BeginUpdate)
	$a__IconDock[$iIndex][11] = 0; X Offset
	$a__IconDock[$iIndex][12] = 0; Y Offset
	$a__IconDock[$iIndex][13] = 0; Scroll Offset
	$a__IconDock[$iIndex][14] = "";HoverFunc
	$a__IconDock[$iIndex][15] = -1 ; UpdateTimer
	$a__IconDock[$iIndex][19] = -1 ; Mouse-X
	$a__IconDock[$iIndex][20] = -1 ; Mouse-Y
	$a__IconDock[$iIndex][21] = 1.8 ; CalcSpeed

	__IconDock_SetIndex($hWnd_Icon, $iIndex)

	If $iIndex = 1 Then
		If @AutoItVersion <= "3.3.0.0" Then
			Execute('Opt("OnExitFunc", "__IconDock_OnExitFunc")')
		Else
			Execute('OnAutoItExitRegister("__IconDock_OnExitFunc")')
		EndIf
	EndIf

	GUISetState(@SW_SHOWNOACTIVATE, $hWnd_Icon)
	If $hLastCreatedGui Then GUISwitch($hLastCreatedGui)

	If $bOnTop And $h__IconDock_EventProc = -1 Then
		$h__IconDock_EventProc = DllCallbackRegister("__IconDock_WinEventProc", "none", "hwnd;int;hwnd;long;long;int;int")
		Local $aRet = DllCall("User32.dll", "hwnd", "SetWinEventHook", "uint", 0x03, "uint", 0x03, "hwnd", 0, "ptr", DllCallbackGetPtr($h__IconDock_EventProc), "int", 0, "int", 0, "uint", 0x2)
		If Not @error And IsArray($aRet) Then $h__IconDock_EventHook = $aRet[0]
	EndIf

	If $h__IconDock_MsgProc = -1 Then $h__IconDock_MsgProc = DllCallbackRegister('__IconDock_MsgProc', 'ptr', 'uint;wparam;lparam')
	If $h__IconDock_MouseProc = -1 Then $h__IconDock_MouseProc = DllCallbackRegister('__IconDock_MouseProc', 'ptr', 'uint;wparam;lparam')
	If $h__IconDock_MsgHook = -1 And $h__IconDock_MouseHook = -1 Then
		Local $hPid = 0
		Local $hThreadID = _WinAPI_GetWindowThreadProcessId($hWnd_Icon, $hPid)
		$h__IconDock_MsgHook = _WinAPI_SetWindowsHookEx($WH_GETMESSAGE, DllCallbackGetPtr($h__IconDock_MsgProc), 0, $hThreadID)
		$h__IconDock_MouseHook = _WinAPI_SetWindowsHookEx($WH_MOUSE, DllCallbackGetPtr($h__IconDock_MouseProc), 0, $hThreadID)
		GUIRegisterMsg(0x0021, "__IconDock_NoActivate")
		GUIRegisterMsg($i__IconDock_UniqueMsg, "__IconDock_CallFunction")
	EndIf

	Return $hWnd_Icon
EndFunc   ;==>_IconDock_Create

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_Destroy()
; Description ...: Destroys an IconDock
; Syntax ........: _IconDock_Destroy($hIconDock)
; Parameters ....: $hIconDock - Handle as returned by _IconDock_Create
; Return values .: Success: True
;                  Failure: False and sets @error to 1
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_Destroy($hIconDock)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)

	Local $aWindow = $a__IconDock[$iIndex][2]
	If $a__IconDock[$iIndex][15] <> -1 Then DllCall("user32.dll", "int", "KillTimer", "hwnd", $aWindow[1], "uint_ptr", $a__IconDock[$iIndex][15])
	GUIDelete($aWindow[1])

	__IconDock_SetIndex($aWindow[1], 0)

	$a__IconDock[0][1] = StringReplace($a__IconDock[0][1], "|" & String($aWindow[1]), "")

	__IconDock_TrackMouseEvent($aWindow[1], 0x80000000) ; cancel last mousetrack

	Local $aIcons = $a__IconDock[$iIndex][0]
	For $i = 1 To $aIcons[0][0]
		_GDIPlus_BitmapDispose($aIcons[$i][6])
	Next

	Local $aValues = $a__IconDock[$iIndex][3]
	_GDIPlus_BrushDispose($aValues[6])
	_GDIPlus_BrushDispose($aValues[14])
	_GDIPlus_StringFormatDispose($aValues[7])
	_GDIPlus_FontFamilyDispose($aValues[8])
	_GDIPlus_FontDispose($aValues[9])
	$aValues[10] = 0

	Local $aNew[$a__IconDock[0][0]][21]
	Local $iCnt = 0
	For $i = 1 To $a__IconDock[0][0]
		If $i = $iIndex Then ContinueLoop
		$iCnt += 1
		For $j = 0 To 20
			$aNew[$iCnt][$j] = $a__IconDock[$i][$j]
		Next
		$aWindow = $a__IconDock[$i][2]
		__IconDock_SetIndex($aWindow[1], $iCnt)
	Next

	$aNew[0][0] = $a__IconDock[0][0] - 1
	$a__IconDock = $aNew
	_GDIPlus_Shutdown()
	Return True
EndFunc   ;==>_IconDock_Destroy

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_EndUpdate()
; Description ...: enables repainting of the IconDock
; Syntax ........: _IconDock_EndUpdate($hIconDock)
; Parameters ....: $hIconDock - Handle as returned by _IconDock_Create
; Return values .: Success
;                  Failure
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......: _IconDock_BeginUpdate
; Example .......:
; =================================================================================================
Func _IconDock_EndUpdate($hIconDock)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)
	$a__IconDock[$iIndex][10] = True
	__IconDock_StartCalcAndDraw($iIndex)
	__IconDock_DrawIcons($iIndex)
EndFunc   ;==>_IconDock_EndUpdate

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_Fade
; Description ...: Fade In or Out
; Syntax ........: _IconDock_Fade($hIconDock, ByRef $iFade)
; Parameters ....: $hIconDock - Handle as returned by _IconDock_Create
;                  $iFade     - 1:    Fade Out
;                             - Else: Fade In
; Return values .: Success - True
;                  Failure - False and set @error to 1
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_Fade($hIconDock, ByRef $iFade, $iSpeed = 8)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)
	Local $aIcons = $a__IconDock[$iIndex][0]
	Local $aValues = $a__IconDock[$iIndex][3]
	Switch $iFade
		Case 1 ; Fade Out
			If $aValues[15] < 0 Then Return SetError(1, 3, False)
			$iFade = 0
		Case Else ; Fade in
			If $aValues[15] > 0 Then Return SetError(1, 3, False)
			$iFade = 1
	EndSwitch
	Select
		Case BitAND($aValues[1], $IconDock_Align_Free)
			For $i = 1 To $aIcons[0][0]
				$a__IconDock[$iIndex][8] -= $aValues[15]
			Next
		Case BitAND($aValues[1], $IconDock_Align_Horizontal)
			Select
				Case BitAND($aValues[2], $IconDock_Up)
					For $i = 1 To $aIcons[0][0]
						$aIcons[$i][2] += $aValues[15]
					Next
				Case BitAND($aValues[2], $IconDock_Down)
					For $i = 1 To $aIcons[0][0]
						$aIcons[$i][2] -= $aValues[15]
					Next
				Case Else ;Center
					For $i = 1 To $aIcons[0][0]
						$a__IconDock[$iIndex][8] -= $aValues[15]
					Next
			EndSelect
		Case Else ;Vertical
			Select
				Case BitAND($aValues[2], $IconDock_Left)
					For $i = 1 To $aIcons[0][0]
						$aIcons[$i][1] += $aValues[15]
					Next
				Case BitAND($aValues[2], $IconDock_Right)
					For $i = 1 To $aIcons[0][0]
						$aIcons[$i][1] -= $aValues[15]
					Next
				Case Else ;Center
					For $i = 1 To $aIcons[0][0]
						$a__IconDock[$iIndex][8] -= $aValues[15]
					Next
			EndSelect
	EndSelect
	If $iSpeed < 1 Then $iSpeed = 1
	If $iSpeed > 20 Then $iSpeed = 20
	$a__IconDock[$iIndex][21] = $iSpeed
	$aValues[15] *= -1
	$a__IconDock[$iIndex][0] = $aIcons
	$a__IconDock[$iIndex][3] = $aValues
	If $a__IconDock[$iIndex][10] Then __IconDock_StartCalcAndDraw($iIndex)
	Return True
EndFunc   ;==>_IconDock_Fade

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_GetBitmapFromHIcon()
; Description ...: Convert a hIcon to GDI+ Bitmap
; Syntax ........: _IconDock_GetBitmapFromHIcon($hIcon)
; Parameters ....: $hIcon - hIcon
;                  $iW    - width
;                  $iH    - height
; Return values .: Success: Returns GDI+ Bitmap Handle
;                  Failure: False and sets @error to 1
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_GetBitmapFromHIcon($hIcon, $iW = 0, $iH = 0)
	If $iW = 0 Or $iH = 0 Then
		Local $aRet = DllCall($ghGDIPDll, "uint", "GdipCreateBitmapFromHICON", "hwnd", $hIcon, "int*", 0)
		Local $hBitmap = $aRet[2]
		If $iW = 0 Then $iW = _GDIPlus_ImageGetWidth($hBitmap)
		If $iH = 0 Then $iH = _GDIPlus_ImageGetHeight($hBitmap)
		_GDIPlus_BitmapDispose($hBitmap)
	EndIf

	Local $hIconBitmap = __IconDock_IconToGdiPlus($hIcon, $iW, $iH)

	Return $hIconBitmap
EndFunc   ;==>_IconDock_GetBitmapFromHIcon


; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_GetPos()
; Description ...: Retrieves the IconDock's position
; Syntax ........: _IconDock_GetPos($hIconDock)
; Parameters ....: $hIconDock - Handle as returned by _IconDock_Create
; Return values .: Success: Returns Array:
;                                    $aReturn[0]: left
;                                    $aReturn[1]: top
;                                    $aReturn[2]: width
;                                    $aReturn[3]: height
;                  Failure: False and sets @error to 1
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_GetPos($hIconDock)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)

	Local $aReturn[4]
	Local $aWindow = $a__IconDock[$iIndex][2]

	$aReturn[0] = $aWindow[4]
	$aReturn[1] = $aWindow[5]
	$aReturn[2] = $aWindow[6]
	$aReturn[3] = $aWindow[7]

	Return $aReturn
EndFunc   ;==>_IconDock_GetPos

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_IconAdd()
; Description ...: Add an hIcon to the IconDock
; Syntax ........: _IconDock_IconAdd($hIconDock, $hIcon[, $sEventFunction = ""[, $iEventMsg = 0[, $sText = ""[, $iX = 0[, $iY = 0]]]]])
; Parameters ....: $hIconDock      - Handle as returned by _IconDock_Create
;                  $hIcon          - Handle to an Icon
;                  $sEventFunction - Function that is called if $iEventMsg
;                  $iEventMsg      - specifies on which message the icon should react
;                                      combination (BitOr) of one or more of the following values (0 for all):
;                                         - $IconDock_LBUTTONDOWN:   left mousebutton down
;                                         - $IconDock_LBUTTONUP:     left mousebutton up
;                                         - $IconDock_LBUTTONDBLCLK: left mousebutton doubleclick
;                                         - $IconDock_RBUTTONDOWN:   right mousebutton down
;                                         - $IconDock_RBUTTONUP:     right mousebutton up
;                                         - $IconDock_RBUTTONDBLCLK: right mousebutton doubleclick
;                                         - $IconDock_MBUTTONDOWN:   middle mousebutton down
;                                         - $IconDock_MBUTTONUP:     middle mousebutton up
;                                         - $IconDock_MBUTTONDBLCLK: middle mousebutton doubleclick
;                  $sText          - Icontext
;                  $iX             - X-Position of the Icon (only if $IconDock_Align_Free)
;                  $iY             - Y-Position of the Icon (only if $IconDock_Align_Free)
;                  $iJumpMsg       - specifies at which message the icon begins to jump
;                                      same combinations as $iEventMsg
; Return values .: Success: Returns index of the Icon
;                  Failure: False and sets @error to 1
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_IconAdd($hIconDock, $hIcon, $sEventFunction = "", $iEventMsg = 0, $sText = "", $iX = 0, $iY = 0, $iJumpMsg = 0)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)

	Local $hIconBitmap = __IconDock_IconToGdiPlus($hIcon, $a__IconDock[$iIndex][9], $a__IconDock[$iIndex][9])

	Local $aWindow = $a__IconDock[$iIndex][2]

	Local $aIcons = $a__IconDock[$iIndex][0]
	Local $aJump = $a__IconDock[$iIndex][1]

	Local $iIconIndex = $aIcons[0][0] + 1

	ReDim $aIcons[$iIconIndex + 1][12]
	$aIcons[0][0] = $iIconIndex

	If $iJumpMsg < 0 Then $iJumpMsg = 512

	ReDim $aJump[$iIconIndex + 1][7]
	$aJump[$iIconIndex][1] = False
	$aJump[$iIconIndex][2] = 0
	$aJump[$iIconIndex][3] = 0
	$aJump[$iIconIndex][4] = $aJump[0][4]
	$aJump[$iIconIndex][5] = $aJump[0][5]
	$aJump[$iIconIndex][6] = $iJumpMsg
	$a__IconDock[$iIndex][1] = $aJump

	$aIcons[$iIconIndex][1] = $iX
	$aIcons[$iIconIndex][2] = $iY
	$aIcons[$iIconIndex][3] = $iX
	$aIcons[$iIconIndex][4] = $iY
	$aIcons[$iIconIndex][5] = 0; Current Size -> FadeIn
	$aIcons[$iIconIndex][6] = $hIconBitmap
	$aIcons[$iIconIndex][7] = $sEventFunction
	$aIcons[$iIconIndex][8] = $iEventMsg
	$aIcons[$iIconIndex][9] = $sText
	$aIcons[$iIconIndex][10] = False ;redraw (bitmap changed etc...)
	$aIcons[$iIconIndex][11] = -1; Remove Icon
	$a__IconDock[$iIndex][0] = $aIcons

	__IconDock_CalcOriginalPositions($iIndex)
	Switch $a__IconDock[$iIndex][10];Begin/EndUpdate
		Case True
			__IconDock_StartCalcAndDraw($iIndex)
		Case Else
			$aIcons[$iIconIndex][5] = $a__IconDock[$iIndex][8];MinSize
	EndSwitch

	Return $iIconIndex
EndFunc   ;==>_IconDock_IconAdd

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_IconAddFile()
; Description ...: Extract a hIcon from file and add to the IconDock
; Syntax ........: _IconDock_IconAddFile($hIconDock, $sFileName[, $iIconIndex = 0[, $sEventFunction = ""[, $iEventMsg = 0[, $sText = ""[, $iX = 0[, $iY = 0]]]]]])
; Parameters ....: $hIconDock      - Handle as returned by _IconDock_Create
;                  $sFileName      - Path to the file
;                  $iIconIndex     - Index of the icon to use
;                  $sEventFunction - Function that is called if $iEventMsg
;                  $iEventMsg      - specifies on which message the icon should react
;                                      combination (BitOr) of one or more of the following values (0 for all):
;                                         - $IconDock_LBUTTONDOWN:   left mousebutton down
;                                         - $IconDock_LBUTTONUP:     left mousebutton up
;                                         - $IconDock_LBUTTONDBLCLK: left mousebutton doubleclick
;                                         - $IconDock_RBUTTONDOWN:   right mousebutton down
;                                         - $IconDock_RBUTTONUP:     right mousebutton up
;                                         - $IconDock_RBUTTONDBLCLK: right mousebutton doubleclick
;                                         - $IconDock_MBUTTONDOWN:   middle mousebutton down
;                                         - $IconDock_MBUTTONUP:     middle mousebutton up
;                                         - $IconDock_MBUTTONDBLCLK: middle mousebutton doubleclick
;                  $sText          - Icontext (if "" the filename is used as icontext)
;                  $iX             - X-Position of the Icon (only if $IconDock_Align_Free)
;                  $iY             - Y-Position of the Icon (only if $IconDock_Align_Free)
;                  $iJumpMsg       - specifies at which message the icon begins to jump
;                                      same combinations as $iEventMsg
; Return values .: Success: Returns index of the Icon
;                  Failure: False and sets @error to 1
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_IconAddFile($hIconDock, $sFileName, $iIconIndex = 0, $sEventFunction = "", $iEventMsg = 0, $sText = "", $iX = 0, $iY = 0, $iJumpMsg = 0)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)

	Local $hIcon
	Local $Ret = DllCall('shell32.dll', 'int', 'SHExtractIconsW', 'wstr', $sFileName, 'int', $iIconIndex, 'int', $a__IconDock[$iIndex][9], 'int', $a__IconDock[$iIndex][9], 'ptr*', 0, 'ptr*', 0, 'int', 1, 'int', 0)
	If (@error) Or (Not $Ret[0]) Or (Not $Ret[5]) Then
		$Ret = DllCall('shell32.dll', 'int', 'SHExtractIconsW', 'wstr', $sFileName, 'int', 0, 'int', $a__IconDock[$iIndex][9], 'int', $a__IconDock[$iIndex][9], 'ptr*', 0, 'ptr*', 0, 'int', 1, 'int', 0)
		If (@error) Or (Not $Ret[0]) Or (Not $Ret[5]) Then Return SetError(1, 3, 0)
		$hIcon = $Ret[5]
	Else
		$hIcon = $Ret[5]
	EndIf

	If Not $sText Then $sText = StringTrimLeft($sFileName, StringInStr($sFileName, "\", 0, -1))

	Local $Return = _IconDock_IconAdd($hIconDock, $hIcon, $sEventFunction, $iEventMsg, $sText, $iX, $iY, $iJumpMsg)
	_WinAPI_DestroyIcon($hIcon)
	Return $Return
EndFunc   ;==>_IconDock_IconAddFile

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_IconCalcNonCollisionPosition()
; Description ...: recalculates the icon positions for a free-aligned IconDock to avoid overlapping
; Syntax ........: _IconDock_IconCalcNonCollisionPosition($hIconDock)
; Parameters ....: $hIconDock - Handle as returned by _IconDock_Create
; Return values .: Success
;                  Failure
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_IconCalcNonCollisionPosition($hIconDock)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)
	Local $aIcons = $a__IconDock[$iIndex][0]
	Local $aTemp = $aIcons
	For $i = 1 To $aIcons[0][0]
		$aIcons[$i][5] = $a__IconDock[$iIndex][8]
	Next
	$a__IconDock[$iIndex][0] = $aIcons
	__IconDock_CalcOriginalPositionsFree($iIndex)
	$aIcons = $a__IconDock[$iIndex][0]
	For $i = 1 To $aIcons[0][0]
		$aIcons[$i][5] = $aTemp[$i][5]
	Next
	$a__IconDock[$iIndex][0] = $aIcons
	If $a__IconDock[$iIndex][10] Then
		__IconDock_StartCalcAndDraw($iIndex)
		__IconDock_DrawIcons($iIndex)
	EndIf
EndFunc   ;==>_IconDock_IconCalcNonCollisionPosition

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_IconGetActive()
; Description ...: Retrieves the index of the current active icon
; Syntax ........: _IconDock_IconGetActive($hIconDock)
; Parameters ....: $hIconDock - Handle as returned by _IconDock_Create
; Return values .: Success Index of the active icon
;                  Failure False and sets @error to 1
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_IconGetActive($hIconDock)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)

	Return $a__IconDock[$iIndex][16]
EndFunc   ;==>_IconDock_IconGetActive

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_IconGetBitmap()
; Description ...: Returns a GDI+ bitmap of the hIcon
; Syntax ........: _IconDock_IconGetActive($hIconDock, $iIconIndex, $iFormat = 0x0026200A)
; Parameters ....: $hIconDock  - Handle as returned by _IconDock_Create
;                  $iIconIndex - Index of the icon
;                  $iFormat    - as used in _GDIPlus_BitmapCloneArea
; Return values .: Success Handle to the bitmap
;                  Failure False and sets @error to 1
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......: _GDIPlus_BitmapCloneArea
; Example .......:
; =================================================================================================
Func _IconDock_IconGetBitmap($hIconDock, $iIconIndex, $iFormat = 0x0026200A)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)
	Local $aIcons = $a__IconDock[$iIndex][0]
	If $iIconIndex < 1 Or $iIconIndex > $aIcons[0][0] Then Return SetError(1, 3, False)

	Local $iW = _GDIPlus_ImageGetWidth($aIcons[$iIconIndex][6])
	Local $iH = _GDIPlus_ImageGetHeight($aIcons[$iIconIndex][6])

	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND(_WinAPI_GetDesktopWindow())
	Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics($iW, $iH, $hGraphics)
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)

	_GDIPlus_GraphicsDrawImage($hContext, $aIcons[$iIconIndex][6], 0, 0)
	_GDIPlus_GraphicsDispose($hContext)
	_GDIPlus_GraphicsDispose($hGraphics)
	Return $hBitmap
EndFunc   ;==>_IconDock_IconGetBitmap

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_IconRemove()
; Description ...: Removes an icon from the IconDock
; Syntax ........: _IconDock_IconRemove($hIconDock, $iIconIndex)
; Parameters ....: $hIconDock  - Handle as returned by _IconDock_Create
;                  $iIconIndex - Index of the icon
; Return values .: Success True
;                  Failure False and sets @error to 1
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_IconRemove($hIconDock, $iIconIndex)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)
	Local $aIcons = $a__IconDock[$iIndex][0]
	If $iIconIndex < 1 Or $iIconIndex > $aIcons[0][0] Then Return SetError(1, 3, False)
	Local $aJump = $a__IconDock[$iIndex][1]
	$aJump[$iIconIndex][1] = False
	$aIcons[$iIconIndex][11] = 0;Remove
	$a__IconDock[$iIndex][1] = $aJump
	$a__IconDock[$iIndex][0] = $aIcons
	If $a__IconDock[$iIndex][10] Then __IconDock_StartCalcAndDraw($iIndex)
	Return True
EndFunc   ;==>_IconDock_IconRemove

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_IconSetBitmap()
; Description ...: Sets a new hIcon
; Syntax ........: _IconDock_IconSetBitmap($hIconDock, $iIconIndex, $hBitmap)
; Parameters ....: $hIconDock  - Handle as returned by _IconDock_Create
;                  $iIconIndex - Index of the icon
;                  $hIcon      - New GDI+ Bitmap
; Return values .: Success
;                  Failure
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_IconSetBitmap($hIconDock, $iIconIndex, $hBitmap)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)
	Local $aIcons = $a__IconDock[$iIndex][0]
	If $iIconIndex < 1 Or $iIconIndex > $aIcons[0][0] Then Return SetError(1, 3, False)

	$aIcons[$iIconIndex][6] = $hBitmap
	$aIcons[$iIconIndex][10] = True
	$a__IconDock[$iIndex][0] = $aIcons

	If $a__IconDock[$iIndex][10] Then __IconDock_StartCalcAndDraw($iIndex)
	Return True
EndFunc   ;==>_IconDock_IconSetBitmap

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_IconSetIcon()
; Description ...: Sets a new hIcon
; Syntax ........: _IconDock_IconSetIcon($hIconDock, $iIconIndex, $hIcon)
; Parameters ....: $hIconDock  - Handle as returned by _IconDock_Create
;                  $iIconIndex - Index of the icon
;                  $hIcon      - New hIcon
; Return values .: Success
;                  Failure
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_IconSetIcon($hIconDock, $iIconIndex, $hIcon)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)
	Local $aIcons = $a__IconDock[$iIndex][0]
	If $iIconIndex < 1 Or $iIconIndex > $aIcons[0][0] Then Return SetError(1, 3, False)

	Local $hIconBitmap = __IconDock_IconToGdiPlus($hIcon, $a__IconDock[$iIndex][9], $a__IconDock[$iIndex][9])
	If @error Or Not $hIconBitmap Then Return SetError(1, 4, False)
	_GDIPlus_BitmapDispose($aIcons[$iIconIndex][6])
	$aIcons[$iIconIndex][6] = $hIconBitmap
	$aIcons[$iIconIndex][10] = True

	$a__IconDock[$iIndex][0] = $aIcons

	If $a__IconDock[$iIndex][10] Then __IconDock_StartCalcAndDraw($iIndex)
	Return True
EndFunc   ;==>_IconDock_IconSetIcon

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_IconSetIndex()
; Description ...: Sets a new index of an icon
; Syntax ........: _IconDock_IconSetIndex($hIconDock, $iIconIndex, $iNewIndex)
; Parameters ....: $hIconDock  - Handle as returned by _IconDock_Create
;                  $iIconIndex - Old index of the icon
;                  $iNewIndex  - New index of the icon
; Return values .: Success
;                  Failure
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_IconSetIndex($hIconDock, $iIconIndex, $iNewIndex)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)
	Local $aIcons = $a__IconDock[$iIndex][0]
	If $iIconIndex < 1 Or $iIconIndex > $aIcons[0][0] Then Return SetError(1, 3, False)
	If $iIconIndex = $iNewIndex Then Return SetError(1, 4, False)
	If $iNewIndex < 1 Or $iNewIndex > $aIcons[0][0] Then Return SetError(1, 5, False)
	$aIcons[$iIconIndex][11] = $iNewIndex;SetNewIndex
	$a__IconDock[$iIndex][0] = $aIcons
	Local $aJump = $a__IconDock[$iIndex][1]
	$aJump[$iIconIndex][1] = False
	$aJump[$iNewIndex][1] = False
	$a__IconDock[$iIndex][1] = $aJump
	If $a__IconDock[$iIndex][10] Then __IconDock_StartCalcAndDraw($iIndex)
	Return True
EndFunc   ;==>_IconDock_IconSetIndex

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_IconSetPos()
; Description ...: Sets a new index of an icon
; Syntax ........: _IconDock_IconSetPos($hIconDock, $iIconIndex, $iX, $iY)
; Parameters ....: $hIconDock  - Handle as returned by _IconDock_Create
;                  $iIconIndex - index of the icon
;                  $iX         - New X position of the icon
;                  $iY         - New Y position of the icon
; Return values .: Success
;                  Failure
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_IconSetPos($hIconDock, $iIconIndex, $iX, $iY)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)
	Local $aIcons = $a__IconDock[$iIndex][0]
	If $iIconIndex < 1 Or $iIconIndex > $aIcons[0][0] Then Return SetError(1, 3, False)

	$aIcons[$iIconIndex][1] = $iX
	$aIcons[$iIconIndex][2] = $iY
	$a__IconDock[$iIndex][0] = $aIcons
	If $a__IconDock[$iIndex][10] Then __IconDock_StartCalcAndDraw($iIndex)
	Return True
EndFunc   ;==>_IconDock_IconSetPos

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_SetAlpha()
; Description ...: Sets the transparency of the IconDock and the Shadow
; Syntax ........: _IconDock_SetAlpha($hIconDock[, $iAlphaIcons = 1[, $iAlphaShadow = 0]])
; Parameters ....: $hIconDock    - Handle as returned by _IconDock_Create
;                  $iAlphaIcons  - Transparency of the Icons [0.1 to 1]
;                  $iAlphaShadow - Transparency of the Shadow [0 to 1]
; Return values .: Success
;                  Failure
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_SetAlpha($hIconDock, $iAlphaIcons = 1, $iAlphaShadow = 0)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)

	Local $aWindow = $a__IconDock[$iIndex][2]

	If $iAlphaIcons < 0.1 Then $iAlphaIcons = 0.1
	If $iAlphaIcons > 1 Then $iAlphaIcons = 1
	If $iAlphaShadow < 0 Then $iAlphaShadow = 0
	If $iAlphaShadow > 1 Then $iAlphaShadow = 1
	$aWindow[8] = $iAlphaIcons ; Alpha Icon
	$aWindow[9] = $iAlphaShadow ; Alpha Shadow

	$a__IconDock[$iIndex][2] = $aWindow

	If $a__IconDock[$iIndex][10] Then __IconDock_DrawIcons($iIndex)
EndFunc   ;==>_IconDock_SetAlpha

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_SetOnActiveChange()
; Description ...: Sets a function that is called when the current active Icon changes
; Syntax ........: _IconDock_SetOnActiveChange($hIconDock[, $sFunc = ""])
; Parameters ....: $hIconDock - Handle as returned by _IconDock_Create
;                  $sFunc     - [optional]  (default:"")
; Return values .: Success
;                  Failure
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_SetOnActiveChange($hIconDock, $sFunc = "")
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)

	$a__IconDock[$iIndex][14] = $sFunc
EndFunc   ;==>_IconDock_SetOnActiveChange

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_SetOffset()
; Description ...: Optional Offset of the Icons
; Syntax ........: _IconDock_SetOffset($hIconDock[, $iOffset = 0])
; Parameters ....: $hIconDock - Handle as returned by _IconDock_Create
;                  $iOffset   - Offset depending on alignment
; Return values .: Success
;                  Failure
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_SetOffset($hIconDock, $iOffset = 0)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)

	Local $aValues = $a__IconDock[$iIndex][3]
	$aValues[13] = $iOffset
	$a__IconDock[$iIndex][3] = $aValues

	If $a__IconDock[$iIndex][10] Then
		__IconDock_CalcOriginalPositions($iIndex)
		__IconDock_StartCalcAndDraw($iIndex)
		__IconDock_DrawIcons($iIndex)
	EndIf
EndFunc   ;==>_IconDock_SetOffset

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_SetPos()
; Description ...: Set the position of the IconDock
; Syntax ........: _IconDock_SetPos($hIconDock[, $iX = ''[, $iY = ''[, $iW = ''[, $iH = '']]]])
; Parameters ....: $hIconDock - Handle as returned by _IconDock_Create
;                  $iX        - [optional]  (default:'')
;                  $iY        - [optional]  (default:'')
;                  $iW        - [optional]  (default:'')
;                  $iH        - [optional]  (default:'')
; Return values .: Success
;                  Failure
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_SetPos($hIconDock, $iX = '', $iY = '', $iW = '', $iH = '')
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)

	Local $aWindow = $a__IconDock[$iIndex][2]

	Local $tPoint = DllStructCreate("int X;int Y")
	DllStructSetData($tPoint, 1, $iX)
	DllStructSetData($tPoint, 2, $iY)
	If $aWindow[2] Then _WinAPI_ClientToScreen($aWindow[2], $tPoint)

	If IsNumber($iX) Then $aWindow[4] = DllStructGetData($tPoint, 1)
	If IsNumber($iY) Then $aWindow[5] = DllStructGetData($tPoint, 2)
	If IsNumber($iW) Then $aWindow[6] = $iW
	If IsNumber($iH) Then $aWindow[7] = $iH
	_WinAPI_SetWindowPos($aWindow[1], 0, $aWindow[4], $aWindow[5], $aWindow[6], $aWindow[7], 540)
	$a__IconDock[$iIndex][2] = $aWindow
	$a__IconDock[$iIndex][11] = 0
	$a__IconDock[$iIndex][12] = 0
	$a__IconDock[$iIndex][13] = 0
	$a__IconDock[$iIndex][17] = 0
	$a__IconDock[$iIndex][18] = 0
	If $a__IconDock[$iIndex][10] Then
		__IconDock_CalcOriginalPositions($iIndex)
		__IconDock_StartCalcAndDraw($iIndex)
		__IconDock_DrawIcons($iIndex)
	EndIf
	Return True
EndFunc   ;==>_IconDock_SetPos

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_SetShadowOffset()
; Description ...: Sets the offset of the shadow
; Syntax ........: _IconDock_SetShadowOffset($hIconDock, $iX, $iY)
; Parameters ....: $hIconDock  - Handle as returned by _IconDock_Create
;                  $fX         - X offset
;                  $fY         - Y offset
; Return values .: Success
;                  Failure
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_SetShadowOffset($hIconDock, $fX = -0.08, $fY = -0.12)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)
	Local $aValues = $a__IconDock[$iIndex][3]
	$aValues[11] = $fX
	$aValues[12] = $fY
	$a__IconDock[$iIndex][3] = $aValues
	If $a__IconDock[$iIndex][10] Then __IconDock_DrawIcons($iIndex)
	Return True
EndFunc   ;==>_IconDock_SetShadowOffset

; #FUNCTION# ======================================================================================
; Name ..........: _IconDock_SetIconSize()
; Description ...: Sets the size of the icons
; Syntax ........: _IconDock_SetIconSize($hIconDock, $iIconSizeMin, $iIconSizeMax = 0)
; Parameters ....: $hIconDock  - Handle as returned by _IconDock_Create
;                  $iIconSizeMin         - Size of non active icons
;                  $iIconSizeMax         - Size of active icon
; Return values .: Success
;                  Failure
; Author ........: Eukalyptus
; Modified ......:
; Remarks .......:
; Related .......:
; Example .......:
; =================================================================================================
Func _IconDock_SetIconSize($hIconDock, $iIconSizeMin, $iIconSizeMax = 0)
	Local $iIndex = __IconDock_GetIndex($hIconDock)
	If Not $iIndex Then Return SetError(1, 2, False)
	If $iIconSizeMin < 1 Then $iIconSizeMin = 1
	If $iIconSizeMax = 0 Then $iIconSizeMax = $iIconSizeMin
	$a__IconDock[$iIndex][8] = $iIconSizeMin
	$a__IconDock[$iIndex][9] = $iIconSizeMax
	If $a__IconDock[$iIndex][10] Then
		__IconDock_CalcOriginalPositions($iIndex)
		__IconDock_StartCalcAndDraw($iIndex)
		__IconDock_DrawIcons($iIndex)
	EndIf
	Return True
EndFunc   ;==>_IconDock_SetIconSize






; =================================================================================================
; Internal Functions
; =================================================================================================







; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_CalcJump()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_CalcJump($iIndex)
	Local $aIcons = $a__IconDock[$iIndex][0]
	Local $aJump = $a__IconDock[$iIndex][1]
	Local $aValues = $a__IconDock[$iIndex][3]
	Local $iTimerDiff, $iJump, $iHeight, $iTime, $bDraw = False
	For $i = 1 To $aIcons[0][0]
		If $aJump[$i][1] Then
			$bDraw = True
			$iTimerDiff = TimerDiff($aJump[$i][2])
			If $iTimerDiff > $aJump[$i][5] Then $aJump[$i][1] = False

			$iHeight = $aJump[$i][3];($aJump[$i][5]-$iTimerDiff) * $aJump[$i][3] / $aJump[$i][5]
			$iTime = $aJump[$i][4];(($aJump[$i][5]*2-$iTimerDiff) * $aJump[$i][4] / $aJump[$i][5]) / 2

			$iTimerDiff = Mod($iTimerDiff, $iTime)
			$iJump = Sin($iTimerDiff * 3.14 / $iTime) * $iHeight / 2
			Select
				Case BitAND($aValues[2], $IconDock_Up)
					$aIcons[$i][4] -= $iJump
				Case BitAND($aValues[2], $IconDock_Down)
					$aIcons[$i][4] += $iJump
				Case BitAND($aValues[2], $IconDock_Left)
					$aIcons[$i][3] -= $iJump
				Case BitAND($aValues[2], $IconDock_Right)
					$aIcons[$i][3] += $iJump
				Case Else
					$aIcons[$i][3] -= $iJump / 2
					$aIcons[$i][4] -= $iJump / 2
					$aIcons[$i][5] += $iJump
			EndSelect
		EndIf
	Next
	$a__IconDock[$iIndex][1] = $aJump
	$a__IconDock[$iIndex][0] = $aIcons
	Return $bDraw
EndFunc   ;==>__IconDock_CalcJump

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_CalcOffset()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_CalcOffset($iIndex)
	Local $aWindow = $a__IconDock[$iIndex][2]
	Local $aValues = $a__IconDock[$iIndex][3]
	Select
		Case BitAND($aValues[1], $IconDock_Align_Horizontal)
			Select
				Case BitAND($aValues[1], $IconDock_Left)
					$a__IconDock[$iIndex][11] = 0
				Case BitAND($aValues[1], $IconDock_Right)
					$a__IconDock[$iIndex][11] = $aWindow[6] - $a__IconDock[$iIndex][6]
				Case Else
					$a__IconDock[$iIndex][11] = $aWindow[6] / 2 - $a__IconDock[$iIndex][6] / 2
			EndSelect
			$a__IconDock[$iIndex][12] = 0
		Case BitAND($aValues[1], $IconDock_Align_Vertical)
			Select
				Case BitAND($aValues[1], $IconDock_Up)
					$a__IconDock[$iIndex][12] = 0
				Case BitAND($aValues[1], $IconDock_Down)
					$a__IconDock[$iIndex][12] = $aWindow[7] - $a__IconDock[$iIndex][7]
				Case Else
					$a__IconDock[$iIndex][12] = $aWindow[7] / 2 - $a__IconDock[$iIndex][7] / 2
			EndSelect
			$a__IconDock[$iIndex][11] = 0
		Case Else
			$a__IconDock[$iIndex][11] = 0
			$a__IconDock[$iIndex][12] = 0
	EndSelect
EndFunc   ;==>__IconDock_CalcOffset

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_CalcOriginalPositions()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_CalcOriginalPositions($iIndex)
	Local $aWindow = $a__IconDock[$iIndex][2]
	Local $aValues = $a__IconDock[$iIndex][3]
	If Not BitAND($aValues[1], $IconDock_Align_Horizontal) And Not BitAND($aValues[1], $IconDock_Align_Vertical) Then Return
	Local $iXY = 0
	Local $bHorizontal = True
	If BitAND($aValues[1], $IconDock_Align_Vertical) Then $bHorizontal = False
	Local $iLeftRight = 0, $iUpDown = 0
	If BitAND($aValues[2], $IconDock_Left) Then $iLeftRight = 1
	If BitAND($aValues[2], $IconDock_Right) Then $iLeftRight = 2
	If BitAND($aValues[2], $IconDock_Up) Then $iUpDown = 1
	If BitAND($aValues[2], $IconDock_Down) Then $iUpDown = 2

	Local $aIcons = $a__IconDock[$iIndex][0]
	Local $aTemp = $aIcons
	For $i = 1 To $aIcons[0][0]
		$aIcons[$i][5] = $a__IconDock[$iIndex][8]
		Switch $bHorizontal
			Case True
				$aIcons[$i][1] = $iXY
				Switch $iUpDown
					Case 1 ; Up
						$aIcons[$i][2] = $aWindow[7] - $a__IconDock[$iIndex][8] - $aValues[13]
					Case 2 ; Down
						$aIcons[$i][2] = $aValues[13]
					Case Else ;Center
						$aIcons[$i][2] = $aWindow[7] / 2 - $a__IconDock[$iIndex][8] / 2 + $aValues[13]
				EndSwitch
				$iXY += $a__IconDock[$iIndex][8]

			Case Else
				$aIcons[$i][2] = $iXY
				Switch $iLeftRight
					Case 1 ; Left
						$aIcons[$i][1] = $aWindow[6] - $a__IconDock[$iIndex][8] - $aValues[13]
					Case 2 ; Right
						$aIcons[$i][1] = $aValues[13]
					Case Else ;Center
						$aIcons[$i][1] = $aWindow[6] / 2 - $a__IconDock[$iIndex][8] / 2 + $aValues[13]
				EndSwitch
				$iXY += $a__IconDock[$iIndex][8]
		EndSwitch
		$aIcons[$i][3] = $aIcons[$i][1]
		$aIcons[$i][4] = $aIcons[$i][2]
	Next
	$a__IconDock[$iIndex][0] = $aIcons
	__IconDock_CalcPos($iIndex)
	__IconDock_CalcOffset($iIndex)
	$a__IconDock[$iIndex][17] = $a__IconDock[$iIndex][11]
	$a__IconDock[$iIndex][18] = $a__IconDock[$iIndex][12]
	$aIcons = $a__IconDock[$iIndex][0]
	For $i = 1 To $aIcons[0][0]
		$aIcons[$i][5] = $aTemp[$i][5]
	Next
	$a__IconDock[$iIndex][0] = $aIcons
EndFunc   ;==>__IconDock_CalcOriginalPositions

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_CalcOriginalPositionsFree()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_CalcOriginalPositionsFree($iIndex)
	Local $aWindow = $a__IconDock[$iIndex][2]
	Local $aValues = $a__IconDock[$iIndex][3]
	If $aValues[3] Then ; Free Sidestep
		Local $sIndex = ""
		Local $aIcons = $a__IconDock[$iIndex][0]
		For $i = 1 To $aIcons[0][0]
			$sIndex = ""
			__IconDock_FreeSideStep($aIcons, $i, $a__IconDock[$iIndex][8], $i, $sIndex)
		Next
		For $i = 1 To $aIcons[0][0]
			$aIcons[$i][1] = $aIcons[$i][3]
			$aIcons[$i][2] = $aIcons[$i][4]
		Next
		$a__IconDock[$iIndex][0] = $aIcons
	EndIf
	Return
EndFunc   ;==>__IconDock_CalcOriginalPositionsFree

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_CalcPos()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_CalcPos($iIndex)
	Local $aWindow = $a__IconDock[$iIndex][2]
	Local $aValues = $a__IconDock[$iIndex][3]

	Local $iOffsetX = $a__IconDock[$iIndex][11]
	Local $iOffsetY = $a__IconDock[$iIndex][12]
	Local $iOffsetS = $a__IconDock[$iIndex][13]

	Local $iLeftRight = 0, $iUpDown = 0
	If BitAND($aValues[2], $IconDock_Left) Then $iLeftRight = 1
	If BitAND($aValues[2], $IconDock_Right) Then $iLeftRight = 2
	If BitAND($aValues[2], $IconDock_Up) Then $iUpDown = 1
	If BitAND($aValues[2], $IconDock_Down) Then $iUpDown = 2
	Local $iXY = 0, $iMinX = $aWindow[6], $iMinY = $aWindow[7], $iMaxX = 0, $iMaxY = 0
	Local $iX, $iY, $bDraw = False
	Local $iIconSizeMin = $a__IconDock[$iIndex][8]
	Local $bFree = False
	If Not BitAND($aValues[1], $IconDock_Align_Horizontal) And Not BitAND($aValues[1], $IconDock_Align_Vertical) Then $bFree = True

	Switch $bFree
		Case True
			Switch $aValues[3]
				Case False ;Not Sidestep
					Local $aIcons = $a__IconDock[$iIndex][0]
					For $i = 1 To $aIcons[0][0]
						Switch $iLeftRight
							Case 1; Left
								$iX = $aIcons[$i][1] + $iIconSizeMin - $aIcons[$i][5]
							Case 2; Right
								$iX = $aIcons[$i][1]
							Case Else ; Center
								$iX = $aIcons[$i][1] + $iIconSizeMin / 2 - $aIcons[$i][5] / 2
						EndSwitch
						Switch $iUpDown
							Case 1; Up
								$iY = $aIcons[$i][2] + $iIconSizeMin - $aIcons[$i][5]
							Case 2; Down
								$iY = $aIcons[$i][2]
							Case Else ; Center
								$iY = $aIcons[$i][2] + $iIconSizeMin / 2 - $aIcons[$i][5] / 2
						EndSwitch
						If $aIcons[$i][3] < $iX - 1 Or $aIcons[$i][3] > $iX + 1 Or $aIcons[$i][4] < $iY - 1 Or $aIcons[$i][4] > $iY + 1 Then $bDraw = True
						$aIcons[$i][3] += ($iX - $aIcons[$i][3]) / $a__IconDock[$iIndex][21]
						$aIcons[$i][4] += ($iY - $aIcons[$i][4]) / $a__IconDock[$iIndex][21] ;calcspeed
						If $aIcons[$i][3] < $iMinX Then $iMinX = $aIcons[$i][3]
						If $aIcons[$i][3] + $aIcons[$i][5] > $iMaxX Then $iMaxX = $aIcons[$i][3] + $aIcons[$i][5]
						If $aIcons[$i][4] < $iMinY Then $iMinY = $aIcons[$i][4]
						If $aIcons[$i][4] + $aIcons[$i][5] > $iMaxY Then $iMaxY = $aIcons[$i][4] + $aIcons[$i][5]
					Next
					$a__IconDock[$iIndex][0] = $aIcons
				Case Else ;SideStep
					Local $aMinMax = __IconDock_CalcPosFreeSideStep($iIndex)
					$iMinX = $aMinMax[0]
					$iMinY = $aMinMax[1]
					$iMaxX = $aMinMax[2]
					$iMaxY = $aMinMax[3]
			EndSwitch
		Case Else
			Local $bHorizontal = True
			If BitAND($aValues[1], $IconDock_Align_Vertical) Then $bHorizontal = False

			Local $aIcons = $a__IconDock[$iIndex][0]
			For $i = 1 To $aIcons[0][0]
				Switch $bHorizontal
					Case True
						$iX = $iXY
						Switch $iUpDown
							Case 1; Up
								$iY = $aIcons[$i][2] + $iIconSizeMin - $aIcons[$i][5]
							Case 2; Down
								$iY = $aIcons[$i][2]
							Case Else ; Center
								$iY = $aIcons[$i][2] + $iIconSizeMin / 2 - $aIcons[$i][5] / 2
						EndSwitch

					Case Else
						$iY = $iXY
						Switch $iLeftRight
							Case 1; Left
								$iX = $aIcons[$i][1] + $iIconSizeMin - $aIcons[$i][5]
							Case 2; Right
								$iX = $aIcons[$i][1]
							Case Else ; Center
								$iX = $aIcons[$i][1] + $iIconSizeMin / 2 - $aIcons[$i][5] / 2
						EndSwitch

				EndSwitch

				Switch $aValues[3] ;SideStep
					Case True
						$iXY += $aIcons[$i][5]
					Case Else
						$iXY += $iIconSizeMin
				EndSwitch

				If $aIcons[$i][3] < $iX - 1 Or $aIcons[$i][3] > $iX + 1 Or $aIcons[$i][4] < $iY - 1 Or $aIcons[$i][4] > $iY + 1 Then $bDraw = True
				$aIcons[$i][3] += ($iX - $aIcons[$i][3]) / $a__IconDock[$iIndex][21] ;calcspeed
				$aIcons[$i][4] += ($iY - $aIcons[$i][4]) / $a__IconDock[$iIndex][21]
				If $aIcons[$i][3] < $iMinX Then $iMinX = $aIcons[$i][3]
				If $aIcons[$i][3] + $aIcons[$i][5] > $iMaxX Then $iMaxX = $aIcons[$i][3] + $aIcons[$i][5]
				If $aIcons[$i][4] < $iMinY Then $iMinY = $aIcons[$i][4]
				If $aIcons[$i][4] + $aIcons[$i][5] > $iMaxY Then $iMaxY = $aIcons[$i][4] + $aIcons[$i][5]
			Next
			$a__IconDock[$iIndex][0] = $aIcons
	EndSwitch
	Select
		Case BitAND($aValues[1], $IconDock_Align_Horizontal)
			$a__IconDock[$iIndex][4] = $iMinX + $iOffsetX + $iOffsetS
			$a__IconDock[$iIndex][5] = $iMinY + $iOffsetY
		Case BitAND($aValues[1], $IconDock_Align_Vertical)
			$a__IconDock[$iIndex][4] = $iMinX + $iOffsetX
			$a__IconDock[$iIndex][5] = $iMinY + $iOffsetY + $iOffsetS
		Case Else
			$a__IconDock[$iIndex][4] = $iMinX
			$a__IconDock[$iIndex][5] = $iMinY
	EndSelect
	$a__IconDock[$iIndex][6] = $iMaxX - $iMinX
	$a__IconDock[$iIndex][7] = $iMaxY - $iMinY
	Return $bDraw
EndFunc   ;==>__IconDock_CalcPos

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_CalcPosFreeSideStep()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_CalcPosFreeSideStep($iIndex)
	Local $aWindow = $a__IconDock[$iIndex][2]
	Local $aValues = $a__IconDock[$iIndex][3]

	Local $iLeftRight = 0, $iUpDown = 0
	If BitAND($aValues[2], $IconDock_Left) Then $iLeftRight = 1
	If BitAND($aValues[2], $IconDock_Right) Then $iLeftRight = 2
	If BitAND($aValues[2], $IconDock_Up) Then $iUpDown = 1
	If BitAND($aValues[2], $IconDock_Down) Then $iUpDown = 2
	Local $iXY = 0, $iMinX = $aWindow[6], $iMinY = $aWindow[7], $iMaxX = 0, $iMaxY = 0
	Local $iX, $iY
	Local $iIconSizeMin = $a__IconDock[$iIndex][8]

	Local $aIcons = $a__IconDock[$iIndex][0]
	For $i = 1 To $aIcons[0][0]
		Switch $iLeftRight
			Case 1; Left
				$iX = $aIcons[$i][1] + $iIconSizeMin - $aIcons[$i][5]
			Case 2; Right
				$iX = $aIcons[$i][1]
			Case Else ; Center
				$iX = $aIcons[$i][1] + $iIconSizeMin / 2 - $aIcons[$i][5] / 2
		EndSwitch
		Switch $iUpDown
			Case 1; Up
				$iY = $aIcons[$i][2] + $iIconSizeMin - $aIcons[$i][5]
			Case 2; Down
				$iY = $aIcons[$i][2]
			Case Else ; Center
				$iY = $aIcons[$i][2] + $iIconSizeMin / 2 - $aIcons[$i][5] / 2
		EndSwitch
		$aIcons[$i][3] += ($iX - $aIcons[$i][3]) / 3
		$aIcons[$i][4] += ($iY - $aIcons[$i][4]) / 3
	Next
	Local $sIndex = ""
	__IconDock_FreeSideStep($aIcons, $a__IconDock[$iIndex][16], $iIconSizeMin, $a__IconDock[$iIndex][16], $sIndex)

	For $i = 1 To $aIcons[0][0]
		If $aIcons[$i][3] < $iMinX Then $iMinX = $aIcons[$i][3]
		If $aIcons[$i][3] + $aIcons[$i][5] > $iMaxX Then $iMaxX = $aIcons[$i][3] + $aIcons[$i][5]
		If $aIcons[$i][4] < $iMinY Then $iMinY = $aIcons[$i][4]
		If $aIcons[$i][4] + $aIcons[$i][5] > $iMaxY Then $iMaxY = $aIcons[$i][4] + $aIcons[$i][5]
	Next
	$a__IconDock[$iIndex][0] = $aIcons
	Local $aMinMax[4]
	$aMinMax[0] = $iMinX
	$aMinMax[1] = $iMinY
	$aMinMax[2] = $iMaxX
	$aMinMax[3] = $iMaxY
	Return $aMinMax
EndFunc   ;==>__IconDock_CalcPosFreeSideStep

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_CalcSize()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_CalcSize($iIndex)
	Local $aIcons = $a__IconDock[$iIndex][0]
	Local $aWindow = $a__IconDock[$iIndex][2]
	Local $aValues = $a__IconDock[$iIndex][3]
	Local $iOffsetX = $a__IconDock[$iIndex][17]
	Local $iOffsetY = $a__IconDock[$iIndex][18]
	Local $iOffsetS = $a__IconDock[$iIndex][13]
	Local $iSizeDynamic = $a__IconDock[$iIndex][9] - $a__IconDock[$iIndex][8]
	Local $iDist, $iSize, $iDistMin = $a__IconDock[$iIndex][9] * 2
	Local $bDraw = False
	Local $bFree = False
	Local $bSwitchSize = False
	If $a__IconDock[$iIndex][9] < $a__IconDock[$iIndex][8] Then $bSwitchSize = True
	Local $iOldIndex = $a__IconDock[$iIndex][16]
	If Not BitAND($aValues[1], $IconDock_Align_Horizontal) And Not BitAND($aValues[1], $IconDock_Align_Vertical) Then $bFree = True

	For $i = 1 To $aIcons[0][0]
		$iSize = $a__IconDock[$iIndex][8]
		If $a__IconDock[$iIndex][19] <> -1 Or $a__IconDock[$iIndex][20] <> -1 Then
			Select
				Case BitAND($aValues[1], $IconDock_Align_Horizontal)
					$iDist = Abs(($aIcons[$i][1] + $a__IconDock[$iIndex][8] / 2) + $iOffsetX + $iOffsetS - $a__IconDock[$iIndex][19])
				Case BitAND($aValues[1], $IconDock_Align_Vertical)
					$iDist = Abs(($aIcons[$i][2] + $a__IconDock[$iIndex][8] / 2) + $iOffsetY + $iOffsetS - $a__IconDock[$iIndex][20])
				Case Else ; Free
					$iDist = Sqrt(Abs(($aIcons[$i][1] + $a__IconDock[$iIndex][8] / 2) + $iOffsetX + $iOffsetS - $a__IconDock[$iIndex][19]) ^ 2 + Abs(($aIcons[$i][2] + $a__IconDock[$iIndex][8] / 2) + $iOffsetY + $iOffsetS - $a__IconDock[$iIndex][20]) ^ 2)
			EndSelect


			If $iDist > $aValues[4] Then
				$iSize = $a__IconDock[$iIndex][8]
			Else
				If $iDist < $iDistMin Then
					$a__IconDock[$iIndex][16] = $i ; Current Icon Index
					$iDistMin = $iDist
				EndIf
				$iDist = $aValues[4] - $iDist
				$iSize = $a__IconDock[$iIndex][8] + ($iDist * $iSizeDynamic / $aValues[4])
				Switch $bSwitchSize
					Case False
						If $iSize < $a__IconDock[$iIndex][8] Then $iSize = $a__IconDock[$iIndex][8]
						If $iSize > $a__IconDock[$iIndex][9] Then $iSize = $a__IconDock[$iIndex][9]
					Case Else
						If $iSize > $a__IconDock[$iIndex][8] Then $iSize = $a__IconDock[$iIndex][8]
						If $iSize < $a__IconDock[$iIndex][9] Then $iSize = $a__IconDock[$iIndex][9]
				EndSwitch
			EndIf
		EndIf
		Switch $aIcons[$i][11]
			Case -1
				If $aIcons[$i][5] < $iSize - 1 Or $aIcons[$i][5] > $iSize + 1 Then $bDraw = True
				$aIcons[$i][5] += ($iSize - $aIcons[$i][5]) / $a__IconDock[$iIndex][21] ; Calcspeed
			Case 0 ;Remove
				$bDraw = True
				$iSize = 0
				$aIcons[$i][5] += ($iSize - $aIcons[$i][5]) / 5
				If $aIcons[$i][5] <= 6 Then
					$a__IconDock[$iIndex][0] = $aIcons
					__IconDock_RemoveIcon($iIndex, $i)
					__IconDock_CalcOriginalPositions($iIndex)
					Return True
				EndIf
			Case Else ;Set New Index
				Local $iNewIndex = $aIcons[$i][11]
				$bDraw = True
				$iSize = 0
				If Not $bFree Then $aIcons[$i][5] += ($iSize - $aIcons[$i][5]) / 5
				If $aIcons[$i][5] <= 6 Or $bFree Then
					$aIcons[$i][11] = -1
					$a__IconDock[$iIndex][0] = $aIcons
					__IconDock_SwitchIndex($iIndex, $i, $iNewIndex)
					__IconDock_CalcOriginalPositions($iIndex)
					Return True
				EndIf
		EndSwitch
		If $aIcons[$i][10] Then
			$aIcons[$i][10] = False
			$bDraw = True
		EndIf
	Next
	$a__IconDock[$iIndex][0] = $aIcons
	If $a__IconDock[$iIndex][16] <> 0 And $iOldIndex <> $a__IconDock[$iIndex][16] And $a__IconDock[$iIndex][14] <> "" Then
		Local $hWnd = $aWindow[1]
		DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $hWnd, "uint", $i__IconDock_UniqueMsg, "wparam", 0, "lparam", -1)
	EndIf
	Return $bDraw
EndFunc   ;==>__IconDock_CalcSize

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_Calculations()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_Calculations($iIndex)
	Local $bDraw = False
	Local Static $iScroll = $a__IconDock[$iIndex][13]
	If $iScroll <> $a__IconDock[$iIndex][13] Then $bDraw = True
	If __IconDock_CalcSize($iIndex) Then $bDraw = True
	If __IconDock_CalcPos($iIndex) Then $bDraw = True
	__IconDock_CalcOffset($iIndex)
	If __IconDock_CalcJump($iIndex) Then $bDraw = True
	$iScroll = $a__IconDock[$iIndex][13]
	Return $bDraw
EndFunc   ;==>__IconDock_Calculations

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_CallFunction
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_CallFunction($hWnd, $iMsg, $wParam, $lParam)
	Switch $iMsg
		Case $i__IconDock_UniqueMsg
			Local $iIndex = __IconDock_GetIndex($hWnd)
			If Not $iIndex Then Return False
			Switch $lParam
				Case 0
					Call($a__IconDock[$iIndex][14], $hWnd, 0)
				Case -1
					Call($a__IconDock[$iIndex][14], $hWnd, $a__IconDock[$iIndex][16])
				Case Else
					Local $aIcons = $a__IconDock[$iIndex][0]
					Call($aIcons[$wParam][7], $hWnd, $wParam, $lParam)
			EndSwitch
	EndSwitch
	Return True
EndFunc   ;==>__IconDock_CallFunction

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_DrawIcons()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_DrawIcons($iIndex)
	Local $iDrawTimer = TimerInit()
	Local $aIcons = $a__IconDock[$iIndex][0]
	Local $aJump = $a__IconDock[$iIndex][1]
	Local $aWindow = $a__IconDock[$iIndex][2]
	Local $aValues = $a__IconDock[$iIndex][3]

	Local $iWidth = $aWindow[6]
	Local $iHeight = $aWindow[7]

	Local $iCurrent = $a__IconDock[$iIndex][16]

	Local $tSize = DllStructCreate("long X;long Y")
	DllStructSetData($tSize, "X", $iWidth)
	DllStructSetData($tSize, "Y", $iHeight)
	Local $tSource = DllStructCreate("long X;long Y")
	Local $tBlendI = DllStructCreate("byte Op;byte Flags;byte Alpha;byte Format")
	DllStructSetData($tBlendI, "Alpha", $aWindow[8] * 0xFF) ; Alpha Icon
	DllStructSetData($tBlendI, "Format", 1)

	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($aWindow[1])
	Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGraphics)
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsSetSmoothingMode($hContext, 2)

	Local $iScrollX = 0, $iScrollY = 0
	Select
		Case BitAND($aValues[1], $IconDock_Align_Horizontal)
			$iScrollX = $a__IconDock[$iIndex][13]
		Case BitAND($aValues[1], $IconDock_Align_Vertical)
			$iScrollY = $a__IconDock[$iIndex][13]
	EndSelect
	Local $iX, $iY, $iS
	If $aWindow[9] >= 0.1 Then
		For $i = 1 To $aIcons[0][0]
			$iX = $aIcons[$i][3] + $a__IconDock[$iIndex][11] + $iScrollX ; Current Pos + Offset + Scroll
			$iY = $aIcons[$i][4] + $a__IconDock[$iIndex][12] + $iScrollY
			$iS = $aIcons[$i][5]
			If $iX + $iS < 0 Or $iX > $aWindow[6] Or $iY + $iS < 0 Or $iY > $aWindow[7] Then ContinueLoop
			__IconDock_DrawShadow($hContext, $aIcons[$i][6], $iX + $iS * $aValues[11], $iY + $iS * $aValues[12], $iS, $iS, $aWindow[9])
		Next
	EndIf
	For $i = 1 To $aIcons[0][0]
		$iX = $aIcons[$i][3] + $a__IconDock[$iIndex][11] + $iScrollX ; Current Pos + Offset + Scroll
		$iY = $aIcons[$i][4] + $a__IconDock[$iIndex][12] + $iScrollY
		$iS = $aIcons[$i][5]
		If $iX + $iS < 0 Or $iX > $aWindow[6] Or $iY + $iS < 0 Or $iY > $aWindow[7] Then ContinueLoop
		_GDIPlus_GraphicsDrawImageRect($hContext, $aIcons[$i][6], $iX, $iY, $iS, $iS)
	Next
	;DrawText
	If $iCurrent <> 0 And $iCurrent <= $aIcons[0][0] And $aIcons[$iCurrent][9] <> "" Then
		$iX = $aIcons[$iCurrent][3] + $a__IconDock[$iIndex][11] + $iScrollX ; Current Pos + Offset + Scroll
		$iY = $aIcons[$iCurrent][4] + $a__IconDock[$iIndex][12] + $iScrollY
		$iS = $aIcons[$iCurrent][5]
		__IconDock_DrawText($hContext, $iX, $iY, $iS, $aIcons[$iCurrent][9], $aValues, $a__IconDock[$iIndex][9], $aWindow[9])
	EndIf
	For $i = 1 To $aIcons[0][0]
		$iX = $aIcons[$i][3] + $a__IconDock[$iIndex][11] + $iScrollX ; Current Pos + Offset + Scroll
		$iY = $aIcons[$i][4] + $a__IconDock[$iIndex][12] + $iScrollY
		$iS = $aIcons[$i][5]
		If $iX + $iS < 0 Or $iX > $aWindow[6] Or $iY + $iS < 0 Or $iY > $aWindow[7] Then ContinueLoop
		Select
			Case BitAND($aValues[1], $IconDock_Align_Horizontal)
				_GDIPlus_GraphicsFillRect($hContext, $iX - $iS * 0.5, $iY, $iS * 2, $iS, $aValues[14])
			Case BitAND($aValues[1], $IconDock_Align_Vertical)
				_GDIPlus_GraphicsFillRect($hContext, $iX, $iY - $iS * 0.5, $iS, $iS * 2, $aValues[14])
			Case Else
				_GDIPlus_GraphicsFillEllipse($hContext, $iX - $iS * 0.5, $iY - $iS * 0.5, $iS * 2, $iS * 2, $aValues[14])
		EndSelect
	Next

	Local $hDCD = _WinAPI_GetDC($aWindow[1])
	Local $hDCS = _WinAPI_CreateCompatibleDC($hDCD)
	Local $hBmp = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
	_GDIPlus_GraphicsDispose($hContext)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)

	Local $hOrig = _WinAPI_SelectObject($hDCS, $hBmp)

	_WinAPI_UpdateLayeredWindow($aWindow[1], $hDCD, 0, DllStructGetPtr($tSize), $hDCS, DllStructGetPtr($tSource), 0, DllStructGetPtr($tBlendI), 2)

	_WinAPI_SelectObject($hDCS, $hOrig)
	_WinAPI_DeleteObject($hBmp)
	_WinAPI_DeleteDC($hDCS)
	_WinAPI_ReleaseDC($aWindow[1], $hDCD)
EndFunc   ;==>__IconDock_DrawIcons

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_DrawShadow()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_DrawShadow($hGraphics, $hBitmap, $iX, $iY, $iW, $iH, $iAlpha)
	Local $iSRCW = _GDIPlus_ImageGetWidth($hBitmap)
	Local $iSRCH = _GDIPlus_ImageGetHeight($hBitmap)
	Local $tColorMatrix = DllStructCreate("float[5];float[5];float[5];float[5];float[5]")
	DllStructSetData($tColorMatrix, 4, $iAlpha, 4)
	DllStructSetData($tColorMatrix, 5, 1, 5)
	Local $aImgAttrib = DllCall($ghGDIPDll, "int", "GdipCreateImageAttributes", "ptr*", 0)
	DllCall($ghGDIPDll, "int", "GdipSetImageAttributesColorMatrix", "ptr", $aImgAttrib[1], "int", 1, "int", 1, "ptr", DllStructGetPtr($tColorMatrix), "ptr", 0, "int", 0)
	DllCall($ghGDIPDll, "int", "GdipDrawImageRectRectI", "hwnd", $hGraphics, "hwnd", $hBitmap, "int", $iX, "int", $iY, "int", $iW, "int", $iH, "int", 0, "int", 0, "int", $iSRCW, "int", $iSRCH, "int", 2, "ptr", $aImgAttrib[1], "int", 0, "int", 0)
	DllCall($ghGDIPDll, "int", "GdipDisposeImageAttributes", "ptr", $aImgAttrib[1])
EndFunc   ;==>__IconDock_DrawShadow

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_DrawText()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_DrawText($hGraphics, $iX, $iY, $iS, $sText, $aValues, $iIconSizeMax, $iAlphaShadow)
	Local $aInfo = _GDIPlus_GraphicsMeasureString($hGraphics, $sText, $aValues[9], $aValues[10], $aValues[7])
	Local $iW = DllStructGetData($aInfo[0], 3)
	Local $iH = DllStructGetData($aInfo[0], 4)
	Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics($iW, $iH, $hGraphics)
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsSetSmoothingMode($hContext, 2)

	Local $iRX = DllStructGetData($aInfo[0], 1)
	Local $iRY = DllStructGetData($aInfo[0], 2)

	_GDIPlus_BrushSetSolidColor($aValues[6], 0xFF332211)
	For $x = -1 To 1
		For $y = -1 To 1
			DllStructSetData($aInfo[0], 1, $iRX + $x)
			DllStructSetData($aInfo[0], 2, $iRY + $y)
			_GDIPlus_GraphicsDrawStringEx($hContext, $sText, $aValues[9], $aInfo[0], $aValues[7], $aValues[6])
		Next
	Next
	DllStructSetData($aInfo[0], 1, $iRX)
	DllStructSetData($aInfo[0], 2, $iRY)
	_GDIPlus_BrushSetSolidColor($aValues[6], 0xFFFFFFFF)
	_GDIPlus_GraphicsDrawStringEx($hContext, $sText, $aValues[9], $aInfo[0], $aValues[7], $aValues[6])

	Select
		Case BitAND($aValues[2], $IconDock_Up)
			$iRY = $iY + $iS - $iIconSizeMax
		Case BitAND($aValues[2], $IconDock_Down)
			$iRY = $iY + $iS - $iH
		Case Else
			$iRY = $iY + $iS / 2 - $iH / 2
	EndSelect

	Select
		Case BitAND($aValues[2], $IconDock_Left)
			$iRX = $iX + $iS - $iW
		Case BitAND($aValues[2], $IconDock_Right)
			$iRX = $iX
		Case Else
			$iRX = $iX + $iS / 2 - $iW / 2
	EndSelect

	If $iAlphaShadow > 0.1 Then __IconDock_DrawShadow($hGraphics, $hBitmap, $iRX + $iS * $aValues[11], $iRY + $iS * $aValues[12], $iW, $iH, $iAlphaShadow)
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, $iRX, $iRY)

	_GDIPlus_GraphicsDispose($hContext)
	_GDIPlus_BitmapDispose($hBitmap)
EndFunc   ;==>__IconDock_DrawText

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_FreeSideStep()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_FreeSideStep(ByRef $aIcons, $iCurrent, $iIconSizeMin, $iIndex, ByRef $sIndex, $iLevel = 0)
	If $iIndex = 0 Then Return
	If $iLevel > 3 Then Return
	Local $aCalc[$aIcons[0][0] + 1]
	Local $iX1 = $aIcons[$iIndex][3] + $aIcons[$iIndex][5] / 2
	Local $iY1 = $aIcons[$iIndex][4] + $aIcons[$iIndex][5] / 2
	Local $iX2, $iY2, $iDist, $a, $b, $c, $alpha
	For $i = 1 To $aIcons[0][0]
		If $i = $iCurrent Or StringInStr($sIndex, StringFormat("%04s", $i)) Then ContinueLoop
		$iX2 = $aIcons[$i][3] + $aIcons[$i][5] / 2
		$iY2 = $aIcons[$i][4] + $aIcons[$i][5] / 2
		$iDist = Sqrt(Abs($iX1 - $iX2) ^ 2 + Abs($iY1 - $iY2) ^ 2)
		If $iDist < $aIcons[$iIndex][5] / 2 + $aIcons[$i][5] / 2 - $iIconSizeMin / 3 Then
			$a = $iX2 - $iX1
			$b = $iY2 - $iY1
			If $a = 0 Then $a = 1
			If $b = 0 Then $b = 1
			$alpha = ATan($a / $b)
			$c = ($aIcons[$iIndex][5] / 2 + $aIcons[$i][5] / 2 - $iIconSizeMin / 3) - $iDist
			If $a > 0 Then
				$aIcons[$i][3] += Abs($c * Sin($alpha))
			Else
				$aIcons[$i][3] -= Abs($c * Sin($alpha))
			EndIf
			If $b > 0 Then
				$aIcons[$i][4] += Abs($c * Cos($alpha))
			Else
				$aIcons[$i][4] -= Abs($c * Cos($alpha))
			EndIf
			$aCalc[$i] = True
			$sIndex &= "|" & StringFormat("%04s", $i)
		Else
			$aCalc[$i] = False
		EndIf
	Next
	For $i = 1 To $aIcons[0][0]
		If $aCalc[$i] Then __IconDock_FreeSideStep($aIcons, $iCurrent, $iIconSizeMin, $i, $sIndex, $iLevel + 1)
	Next
EndFunc   ;==>__IconDock_FreeSideStep

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_GetIndex()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_GetIndex($hIconDock)
	Local $aRegExp = StringRegExp($s__IconDock, ";" & $hIconDock & ":(\d+)", 3)
	If Not IsArray($aRegExp) Then Return 0
	Return $aRegExp[0]
EndFunc   ;==>__IconDock_GetIndex

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_IconToGdiPlus()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_IconToGdiPlus($hIcon, $iWidth, $iHeight)

	Local $tBITMAPINFO = DllStructCreate("dword Size;long Width;long Height;word Planes;word BitCount;dword Compression;dword SizeImage;long XPelsPerMeter;long YPelsPerMeter;dword ClrUsed;dword ClrImportant;dword RGBQuad")
	DllStructSetData($tBITMAPINFO, 'Size', DllStructGetSize($tBITMAPINFO) - 4)
	DllStructSetData($tBITMAPINFO, 'Width', $iWidth)
	DllStructSetData($tBITMAPINFO, 'Height', -$iHeight)
	DllStructSetData($tBITMAPINFO, 'Planes', 1)
	DllStructSetData($tBITMAPINFO, 'BitCount', 32)
	DllStructSetData($tBITMAPINFO, 'Compression', 0)
	DllStructSetData($tBITMAPINFO, 'SizeImage', 0)

	Local $hDC = _WinAPI_CreateCompatibleDC(0)
	Local $aRet = DllCall('gdi32.dll', 'ptr', 'CreateDIBSection', 'hwnd', 0, 'ptr', DllStructGetPtr($tBITMAPINFO), 'uint', 0, 'ptr*', 0, 'ptr', 0, 'dword', 0)
	Local $pBits = $aRet[4]
	Local $hBmp = $aRet[0]
	Local $hOrig = _WinAPI_SelectObject($hDC, $hBmp)
	_WinAPI_DrawIconEx($hDC, 0, 0, $hIcon, $iWidth, $iHeight)

	Local $bAlpha = False
	Local $tData = DllStructCreate("dword[" & $iWidth * $iHeight & "]", $pBits)
	For $i = 1 To $iWidth * $iHeight
		If BitAND(DllStructGetData($tData, 1, $i), 0xFF000000) Then
			$bAlpha = True
			ExitLoop
		EndIf
	Next
	Switch $bAlpha
		Case True
			$aRet = DllCall($ghGDIPDll, "uint", "GdipCreateBitmapFromScan0", "int", $iWidth, "int", $iHeight, "int", $iWidth * 4, "int", 0x26200A, "ptr", $pBits, "int*", 0)
			Local $hBitmapTemp = $aRet[6]

			Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND(_WinAPI_GetDesktopWindow())
			Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGraphics)
			Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)

			_GDIPlus_GraphicsDrawImage($hContext, $hBitmapTemp, 0, 0)

			_GDIPlus_BitmapDispose($hBitmapTemp)
			_WinAPI_DeleteObject($hBmp)
			_GDIPlus_GraphicsDispose($hContext)
			_GDIPlus_GraphicsDispose($hGraphics)

			_WinAPI_SelectObject($hDC, $hOrig)
			_WinAPI_DeleteDC($hDC)
		Case Else
			$aRet = DllCall($ghGDIPDll, "uint", "GdipCreateBitmapFromHICON", "hwnd", $hIcon, "int*", 0)
			Local $hBitmap = $aRet[2]
			_WinAPI_SelectObject($hDC, $hOrig)
			_WinAPI_DeleteObject($hBmp)
			_WinAPI_DeleteDC($hDC)
	EndSwitch
	Return $hBitmap
EndFunc   ;==>__IconDock_IconToGdiPlus

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_MouseProc()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_MouseProc($iCode, $wParam, $lParam)
	If $iCode < 0 Then Return _WinAPI_CallNextHookEx($h__IconDock_MouseHook, $iCode, $wParam, $lParam)

	Local $tStruct = DllStructCreate("LONG x;LONG y;HWND hwnd;UINT wHitTestCode;ULONG_PTR dwExtraInfo", $lParam)
	Local $hWnd = DllStructGetData($tStruct, 3)
	If Not StringInStr($s__IconDock, ";" & $hWnd & ":") Then Return _WinAPI_CallNextHookEx($h__IconDock_MouseHook, $iCode, $wParam, $lParam)

	Local $iMsg = $wParam
	Local $tPoint = DllStructCreate("LONG x;LONG y;")
	DllStructSetData($tPoint, 1, DllStructGetData($tStruct, 1))
	DllStructSetData($tPoint, 2, DllStructGetData($tStruct, 2))
	_WinAPI_ScreenToClient($hWnd, $tPoint)
	Local $iX = DllStructGetData($tPoint, 1)
	Local $iY = DllStructGetData($tPoint, 2)

	Switch $iMsg
		Case 0x0200; $WM_MOUSEMOVE
			Local $iIndex = __IconDock_GetIndex($hWnd)
			If $iIndex Then
				$a__IconDock[$iIndex][19] = $iX
				$a__IconDock[$iIndex][20] = $iY
				$a__IconDock[$iIndex][21] = 1.8
				__IconDock_StartCalcAndDraw($iIndex)
			EndIf
			__IconDock_TrackMouseEvent($hWnd)

		Case 0x0201 To 0x0209; WM_LBUTTONDOWN, WM_LBUTTONUP, WM_LBUTTONDBLCLK, WM_RBUTTONDOWN, WM_RBUTTONUP, WM_RBUTTONDBLCLK, WM_MBUTTONDOWN, WM_MBUTTONUP, WM_MBUTTONDBLCLK
			Local $iIndex = __IconDock_GetIndex($hWnd)
			If $iIndex Then
				Local $iCurrent = $a__IconDock[$iIndex][16]
				Local $aIcons = $a__IconDock[$iIndex][0]
				Local $bClick = False
				Select
					Case $aIcons[$iCurrent][8] = 0
						$bClick = True
					Case $iMsg = 0x201 And BitAND($aIcons[$iCurrent][8], 1)
						$bClick = True
					Case $iMsg = 0x202 And BitAND($aIcons[$iCurrent][8], 2)
						$bClick = True
					Case $iMsg = 0x203 And BitAND($aIcons[$iCurrent][8], 4)
						$bClick = True
					Case $iMsg = 0x204 And BitAND($aIcons[$iCurrent][8], 8)
						$bClick = True
					Case $iMsg = 0x205 And BitAND($aIcons[$iCurrent][8], 16)
						$bClick = True
					Case $iMsg = 0x206 And BitAND($aIcons[$iCurrent][8], 32)
						$bClick = True
					Case $iMsg = 0x207 And BitAND($aIcons[$iCurrent][8], 64)
						$bClick = True
					Case $iMsg = 0x208 And BitAND($aIcons[$iCurrent][8], 128)
						$bClick = True
					Case $iMsg = 0x209 And BitAND($aIcons[$iCurrent][8], 256)
						$bClick = True
				EndSelect
				If $bClick Then
					Local $bJump = False
					Local $aJump = $a__IconDock[$iIndex][1]
					Select
						Case $aJump[$iCurrent][6] = 0
							$bJump = True
						Case $iMsg = 0x201 And BitAND($aJump[$iCurrent][6], 1)
							$bJump = True
						Case $iMsg = 0x202 And BitAND($aJump[$iCurrent][6], 2)
							$bJump = True
						Case $iMsg = 0x203 And BitAND($aJump[$iCurrent][6], 4)
							$bJump = True
						Case $iMsg = 0x204 And BitAND($aJump[$iCurrent][6], 8)
							$bJump = True
						Case $iMsg = 0x205 And BitAND($aJump[$iCurrent][6], 16)
							$bJump = True
						Case $iMsg = 0x206 And BitAND($aJump[$iCurrent][6], 32)
							$bJump = True
						Case $iMsg = 0x207 And BitAND($aJump[$iCurrent][6], 64)
							$bJump = True
						Case $iMsg = 0x208 And BitAND($aJump[$iCurrent][6], 128)
							$bJump = True
						Case $iMsg = 0x209 And BitAND($aJump[$iCurrent][6], 256)
							$bJump = True
					EndSelect
					If $bJump Then
						__IconDock_StartJump($iIndex, $a__IconDock[$iIndex][16])
						__IconDock_StartCalcAndDraw($iIndex)
					EndIf
					DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $hWnd, "uint", $i__IconDock_UniqueMsg, "wparam", $iCurrent, "lparam", 2 ^ ($iMsg - 0x201))
				EndIf
			EndIf
	EndSwitch

	Return _WinAPI_CallNextHookEx($h__IconDock_MouseHook, $iCode, $wParam, $lParam)
EndFunc   ;==>__IconDock_MouseProc

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_MsgProc()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_MsgProc($iCode, $wParam, $lParam)
	If $iCode < 0 Then Return _WinAPI_CallNextHookEx($h__IconDock_MsgHook, $iCode, $wParam, $lParam)

	Local $tStruct = DllStructCreate("HWND hwnd;UINT message;WPARAM wParam;LPARAM lParam;DWORD time;LONG y;LONG x", $lParam)
	Local $hWnd = DllStructGetData($tStruct, "hwnd")
	If Not StringInStr($s__IconDock, ";" & $hWnd & ":") Then Return _WinAPI_CallNextHookEx($h__IconDock_MsgHook, $iCode, $wParam, $lParam)

	Local $iMsg = DllStructGetData($tStruct, "message")

	Switch $iMsg
		Case 0x02A3; $WM_MOUSELEAVE
			Local $iIndex = __IconDock_GetIndex($hWnd)
			If $iIndex Then
				$a__IconDock[$iIndex][19] = -1
				$a__IconDock[$iIndex][20] = -1
				$a__IconDock[$iIndex][16] = 0
				__IconDock_StartCalcAndDraw($iIndex)
				If $a__IconDock[$iIndex][14] <> "" Then DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $hWnd, "uint", $i__IconDock_UniqueMsg, "wparam", 0, "lparam", 0)
			EndIf

		Case 0x02A1;WM_MOUSEHOVER
			Local $iIndex = __IconDock_GetIndex($hWnd)
			If $iIndex Then
				If __IconDock_Scroll($iIndex) Then
					__IconDock_StartCalcAndDraw($iIndex)
					__IconDock_TrackMouseEvent($hWnd)
				EndIf
			EndIf

	EndSwitch

	Return _WinAPI_CallNextHookEx($h__IconDock_MsgHook, $iCode, $wParam, $lParam)
EndFunc   ;==>__IconDock_MsgProc

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_NoActivate()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_NoActivate($hWnd, $iMsg, $wParam, $lParam)
	If Not StringInStr($s__IconDock, ";" & $hWnd & ":") Then Return 'GUI_RUNDEFMSG'
	If $iMsg = 0x0021 Then Return 4
	Return 'GUI_RUNDEFMSG'
EndFunc   ;==>__IconDock_NoActivate

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_OnExitFunc()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_OnExitFunc()
	Local $aWindow
	While $a__IconDock[0][0] > 0
		$aWindow = $a__IconDock[1][2]
		_IconDock_Destroy($aWindow[1])
	WEnd
	If $h__IconDock_MsgHook <> -1 Then _WinAPI_UnhookWindowsHookEx($h__IconDock_MsgHook)
	If $h__IconDock_MouseHook <> -1 Then _WinAPI_UnhookWindowsHookEx($h__IconDock_MouseHook)
	If $h__IconDock_MsgProc <> -1 Then DllCallbackFree($h__IconDock_MsgProc)
	If $h__IconDock_MouseProc <> -1 Then DllCallbackFree($h__IconDock_MouseProc)
	If $h__IconDock_EventHook <> -1 Then DllCall("user32.dll", "int", "UnhookWinEvent", "hwnd", $h__IconDock_EventHook) ; unhook winevent
	If $h__IconDock_EventProc <> -1 Then DllCallbackFree($h__IconDock_EventProc)
	GUIRegisterMsg(0x0021, "")
EndFunc   ;==>__IconDock_OnExitFunc

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_RemoveIcon()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_RemoveIcon($iIndex, $iIconIndex)
	Local $aIcons = $a__IconDock[$iIndex][0]
	Local $aNew[$aIcons[0][0]][12]
	$aNew[0][0] = $aIcons[0][0] - 1
	Local $iCnt = 0
	For $i = 1 To $aIcons[0][0]
		If $i = $iIconIndex Then ContinueLoop
		$iCnt += 1
		For $j = 0 To 11
			$aNew[$iCnt][$j] = $aIcons[$i][$j]
		Next
	Next
	$a__IconDock[$iIndex][0] = $aNew
EndFunc   ;==>__IconDock_RemoveIcon

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_Scroll()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_Scroll($iIndex)
	Local $aValues = $a__IconDock[$iIndex][3]
	If Not BitAND($aValues[1], $IconDock_Align_Horizontal) And Not BitAND($aValues[1], $IconDock_Align_Vertical) Then Return False
	Local $aIcons = $a__IconDock[$iIndex][0]
	Local $aWindow = $a__IconDock[$iIndex][2]

	Local $iOffsetX = $a__IconDock[$iIndex][11]
	Local $iOffsetY = $a__IconDock[$iIndex][12]
	Local $iOffsetS = $a__IconDock[$iIndex][13]
	Local $iScroll = $iOffsetS
	Local $fSpeed
	Local $iThrsHld = $a__IconDock[$iIndex][8] * 1.25
	Local $iSpeed = $a__IconDock[$iIndex][8] * 0.5

	Switch BitAND($aValues[1], $IconDock_Align_Horizontal)
		Case True
			If $a__IconDock[$iIndex][19] < 0 Or $a__IconDock[$iIndex][6] <= $aWindow[6] Then Return False
			Switch $a__IconDock[$iIndex][19]
				Case 0 To $iThrsHld
					$fSpeed = (($iThrsHld - $a__IconDock[$iIndex][19]) / $iThrsHld) ^ 2
					$iScroll += $iSpeed * $fSpeed
					If $iScroll + $iOffsetX > $iThrsHld Then Return False
				Case $aWindow[6] - $iThrsHld To $aWindow[6]
					$fSpeed = (($iThrsHld - ($aWindow[6] - $a__IconDock[$iIndex][19])) / $iThrsHld) ^ 2
					$iScroll -= $iSpeed * $fSpeed
					If $iScroll + $iOffsetX + $a__IconDock[$iIndex][6] < $aWindow[6] - $iThrsHld Then Return False
				Case Else
					Return False
			EndSwitch

		Case Else
			If $a__IconDock[$iIndex][20] < 0 Or $a__IconDock[$iIndex][7] <= $aWindow[7] Then Return False
			If ($a__IconDock[$iIndex][20] > $iThrsHld And $a__IconDock[$iIndex][20] < $aWindow[7] - $iThrsHld) Then Return False
			Switch $a__IconDock[$iIndex][20]
				Case 0 To $iThrsHld
					$fSpeed = (($iThrsHld - $a__IconDock[$iIndex][20]) / $iThrsHld) ^ 2
					$iScroll += $iSpeed * $fSpeed
					If $iScroll + $iOffsetY > $iThrsHld Then Return False
				Case $aWindow[7] - $iThrsHld To $aWindow[7]
					$fSpeed = (($iThrsHld - ($aWindow[7] - $a__IconDock[$iIndex][20])) / $iThrsHld) ^ 2
					$iScroll -= $iSpeed * $fSpeed
					If $iScroll + $iOffsetY + $a__IconDock[$iIndex][7] < $aWindow[7] - $iThrsHld Then Return False
				Case Else
					Return False
			EndSwitch
	EndSwitch
	$a__IconDock[$iIndex][13] = $iScroll
	Return True
EndFunc   ;==>__IconDock_Scroll

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_SetIndex()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_SetIndex($hIconDock, $iIndex)
	If StringInStr($s__IconDock, ";" & $hIconDock & ":") Then $s__IconDock = StringRegExpReplace($s__IconDock, ";" & $hIconDock & ":(\d+)", "")
	If $iIndex Then $s__IconDock &= ";" & $hIconDock & ":" & $iIndex
EndFunc   ;==>__IconDock_SetIndex

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_StartCalcAndDraw()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_StartCalcAndDraw($iIndex)
	If $a__IconDock[$iIndex][15] <> -1 Then Return
	Local $aWindow = $a__IconDock[$iIndex][2]
	Local $aValues = $a__IconDock[$iIndex][3]
	$a__IconDock[$iIndex][15] = Round(TimerInit())
	DllCall("user32.dll", "int", "SetTimer", "hwnd", $aWindow[1], "uint_ptr", $a__IconDock[$iIndex][15], "uint", $aValues[5], "ptr", DllCallbackGetPtr($p__IconDock_TimerProc))
EndFunc   ;==>__IconDock_StartCalcAndDraw

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_StartJump()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_StartJump($iIndex, $iIconIndex)
	Local $aJump = $a__IconDock[$iIndex][1]
	$aJump[$iIconIndex][1] = True
	$aJump[$iIconIndex][2] = TimerInit()
	$aJump[$iIconIndex][3] = $a__IconDock[$iIndex][8] * 0.6
	$aJump[$iIconIndex][4] = $aJump[0][4];800
	$aJump[$iIconIndex][5] = $aJump[0][5];4000
	$a__IconDock[$iIndex][1] = $aJump
EndFunc   ;==>__IconDock_StartJump

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_SwitchIndex()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_SwitchIndex($iIndex, $iIconIndex, $iNewIndex)
	Local $aIcons = $a__IconDock[$iIndex][0]
	Local $aNew[$aIcons[0][0] + 1][12]
	Local $aValues = $a__IconDock[$iIndex][3]
	$aNew[0][0] = $aIcons[0][0]

	;Remove Old Index
	Local $iCnt = -1
	For $i = 0 To $aIcons[0][0]
		If $i = $iIconIndex Then ContinueLoop
		$iCnt += 1
		For $j = 0 To 11
			$aNew[$iCnt][$j] = $aIcons[$i][$j]
		Next
	Next
	;Move
	For $i = $aIcons[0][0] To $iNewIndex Step -1
		For $j = 0 To 11
			$aNew[$i][$j] = $aNew[$i - 1][$j]
		Next
	Next
	;Add New Index
	For $j = 0 To 11
		$aNew[$iNewIndex][$j] = $aIcons[$iIconIndex][$j]
	Next
	If Not BitAND($aValues[1], $IconDock_Align_Horizontal) And Not BitAND($aValues[1], $IconDock_Align_Vertical) Then
		For $i = 1 To $aIcons[0][0]
			$aIcons[$i][1] = $aNew[$i][1]
			$aIcons[$i][2] = $aNew[$i][2]
		Next
		$aNew = $aIcons
	EndIf
	$a__IconDock[$iIndex][0] = $aNew
EndFunc   ;==>__IconDock_SwitchIndex

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_TimerProc()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_TimerProc($hWnd, $uiMsg, $idEvent, $dwTime)
	If Not StringInStr($s__IconDock, ";" & $hWnd & ":") Then Return
	Local $iIndex = __IconDock_GetIndex($hWnd)
	If Not $iIndex Then Return

	Local $bDraw = __IconDock_Calculations($iIndex)

	Switch $bDraw
		Case True
			__IconDock_DrawIcons($iIndex)
		Case Else
			DllCall("user32.dll", "int", "KillTimer", "hwnd", $hWnd, "uint_ptr", $a__IconDock[$iIndex][15])
			$a__IconDock[$iIndex][15] = -1
	EndSwitch
EndFunc   ;==>__IconDock_TimerProc

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_TrackMouseEvent()
; Description ...: Internal Function
; Author ........: GaryFrost
; Modified ......: Eukalyptus
; =================================================================================================
Func __IconDock_TrackMouseEvent($hWnd, $iFlags = 0x00000003); by GaryFrost
	Local $pMouseEvent, $iResult, $iMouseEvent
	Local $tMouseEvent = DllStructCreate("dword Size;dword Flags;hwnd hWndTrack;dword HoverTime")

	$iMouseEvent = DllStructGetSize($tMouseEvent)
	DllStructSetData($tMouseEvent, "Flags", $iFlags)
	DllStructSetData($tMouseEvent, "hWndTrack", $hWnd)
	DllStructSetData($tMouseEvent, "HoverTime", 15)
	DllStructSetData($tMouseEvent, "Size", $iMouseEvent)
	Local $ptrMouseEvent = DllStructGetPtr($tMouseEvent)
	$iResult = DllCall("user32.dll", "int", "TrackMouseEvent", "ptr", $ptrMouseEvent)
	Return $iResult[0] <> 0
EndFunc   ;==>__IconDock_TrackMouseEvent

; #FUNCTION# ======================================================================================
; Name ..........: __IconDock_WinEventProc()
; Description ...: Internal Function
; Author ........: Eukalyptus
; =================================================================================================
Func __IconDock_WinEventProc($hHook, $iEvent, $hWnd, $idObject, $idChild, $iEventThread, $iEventTime); IconDock always on top
	Local $aWnd = StringRegExp($s__IconDock, ";([^:]+)", 3)
	If @error Or Not IsArray($aWnd) Then Return
	Local $iIndex, $aWindow, $iEX_Style, $iValue, $bTop
	;Check if TopMost flag is set and if a non IconDock window is over it
	For $i = 0 To UBound($aWnd) - 1
		If Not StringInStr($s__IconDock, ";" & $aWnd[$i] & ":") Then ContinueLoop
		$iIndex = __IconDock_GetIndex($aWnd[$i])
		$aWindow = $a__IconDock[$iIndex][2]
		Switch $aWindow[3]
			Case True ; TopMost
				$iEX_Style = _WinAPI_GetWindowLong($aWnd[$i], -20); $GWL_EXSTYLE
				If Not BitAND($iEX_Style, 0x00000008) Then WinSetOnTop($aWnd[$i], "", True);$WS_EX_TOPMOST

				$bTop = True
				$iValue = _WinAPI_GetWindow($aWnd[$i], 3);$GW_HWNDPREV
				While 1
					$iValue = _WinAPI_GetWindow($iValue, 3);$GW_HWNDPREV
					If Not $iValue Then ExitLoop
					If Not StringInStr($a__IconDock[0][1], $iValue) And _WinAPI_IsWindowVisible($iValue) Then $bTop = False
				WEnd
				If Not $bTop Then _WinAPI_SetWindowPos($aWnd[$i], -1, 0, 0, 0, 0, BitOR(0x0010, 0x0002, 0x0001))

			Case Else ; Child Window
				; always on top of all child windows?!?
		EndSwitch
	Next
EndFunc   ;==>__IconDock_WinEventProc

;$aIcons[1][12]:
;0/0:Count
;x/1:X-Pos original
;x/2:Y-Pos original
;x/3:X-Pos current
;x/4:Y-Pos current
;x/5:Size current
;x/6:GDI+ hIcon
;x/7:sEventFunction
;x/8:iEventMsg
;x/9:sText
;x/10:Icon or Bitmap changed
;x/11:False: Remove Icon Marker

;$aJump[1][7]:
;x/1:Jump On/Off
;x/2:Jump Timer
;x/3:Jump cycle step
;x/4:Jump cycle time
;x/5:Jump timeout
;x/6:Jump Messages

;$aWindow[10]:
;1: $hWnd
;2: $hParent
;3: $bOnTop
;4: Window X
;5: Window Y
;6: Window W
;7: Window H
;8: $iAlphaIcons
;9: $iAlphaShadow

;$aValues[16]
;1: Align
;2: IconDir
;3: SideStep
;4: Grow ThrsHld
;5: UpdateTime
;6: _GDIPlus_BrushCreateSolid(0xFF332211)
;7: _GDIPlus_StringFormatCreate()
;8: _GDIPlus_FontFamilyCreate("Arial")
;9: _GDIPlus_FontCreate($aLayered[17], $iIconSizeMin * 0.18, 1)
;10: _GDIPlus_RectFCreate(0, 0, 0, 0)
;11: Shadow X
;12: Shadow Y
;13: Optional Icon Offset
;14: MouseBrush
;15: FadeValue

;$a__IconDock[1][22]
;0: $aIcons
;1: $aJump
;2: $aWindow
;3: $aValues
;4: Icon Area X
;5: Icon Area Y
;6: Icon Area W
;7: Icon Area H
;8: Icon Size Min
;9: Icon Size Max
;10: Begin/End Update
;11: Offset X
;12: Offset Y
;13: Scroll Offset
;14: HoverFunc
;15: TimerProc
;16: Current IconIndex
;17: Original Offset X
;18: Original Offset Y
;19: Mouse X
;20: Mouse Y
;21: CalcSpeed Pos