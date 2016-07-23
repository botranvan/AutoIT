#include "IconDock.au3"

HotKeySet("{ESC}", "_Exit")

Global $iIconSizeMin = 80
Global $iIconSizeMax = 128

Global $hIconDock = _IconDock_Create(0, @DesktopHeight / 2, @DesktopWidth, $iIconSizeMax + $iIconSizeMin, _
		BitOR($IconDock_Align_Horizontal, $IconDock_Center), $IconDock_Center, $iIconSizeMin, $iIconSizeMax, True)

_IconDock_SetOnActiveChange($hIconDock, "_ChangeIcon")
_IconDock_SetAlpha($hIconDock, 1, 0.2)
_IconDock_SetShadowOffset($hIconDock, -0.18, 0.22)

_IconDock_BeginUpdate($hIconDock)

Global $aGFX[9][2]
$aGFX[1][0] = _LoadIconToBitmap(@ScriptDir & "\Buttons\PlayPrevious.ico", $iIconSizeMax)
$aGFX[1][1] = _LoadIconToBitmap(@ScriptDir & "\Buttons\PlayPrevious_a.ico", $iIconSizeMax)
_IconDock_IconAdd($hIconDock, 0, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
_IconDock_IconSetBitmap($hIconDock, 1, $aGFX[1][0])

$aGFX[2][0] = _LoadIconToBitmap(@ScriptDir & "\Buttons\FastRew.ico", $iIconSizeMax)
$aGFX[2][1] = _LoadIconToBitmap(@ScriptDir & "\Buttons\FastRew_a.ico", $iIconSizeMax)
_IconDock_IconAdd($hIconDock, 0, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
_IconDock_IconSetBitmap($hIconDock, 2, $aGFX[2][0])

$aGFX[3][0] = _LoadIconToBitmap(@ScriptDir & "\Buttons\Stop.ico", $iIconSizeMax)
$aGFX[3][1] = _LoadIconToBitmap(@ScriptDir & "\Buttons\Stop_a.ico", $iIconSizeMax)
_IconDock_IconAdd($hIconDock, 0, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
_IconDock_IconSetBitmap($hIconDock, 3, $aGFX[3][0])

$aGFX[4][0] = _LoadIconToBitmap(@ScriptDir & "\Buttons\Play.ico", $iIconSizeMax)
$aGFX[4][1] = _LoadIconToBitmap(@ScriptDir & "\Buttons\Play_a.ico", $iIconSizeMax)
_IconDock_IconAdd($hIconDock, 0, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
_IconDock_IconSetBitmap($hIconDock, 4, $aGFX[4][0])

$aGFX[5][0] = _LoadIconToBitmap(@ScriptDir & "\Buttons\FastForward.ico", $iIconSizeMax)
$aGFX[5][1] = _LoadIconToBitmap(@ScriptDir & "\Buttons\FastForward_a.ico", $iIconSizeMax)
_IconDock_IconAdd($hIconDock, 0, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
_IconDock_IconSetBitmap($hIconDock, 5, $aGFX[5][0])

$aGFX[6][0] = _LoadIconToBitmap(@ScriptDir & "\Buttons\Next.ico", $iIconSizeMax)
$aGFX[6][1] = _LoadIconToBitmap(@ScriptDir & "\Buttons\Next_a.ico", $iIconSizeMax)
_IconDock_IconAdd($hIconDock, 0, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
_IconDock_IconSetBitmap($hIconDock, 6, $aGFX[6][0])

$aGFX[7][0] = _LoadIconToBitmap(@ScriptDir & "\Buttons\Record.ico", $iIconSizeMax)
$aGFX[7][1] = _LoadIconToBitmap(@ScriptDir & "\Buttons\Record_a.ico", $iIconSizeMax)
_IconDock_IconAdd($hIconDock, 0, "_EventFunction", $IconDock_LBUTTONUP, "", 0, 0, -1)
_IconDock_IconSetBitmap($hIconDock, 7, $aGFX[7][0])

$aGFX[8][0] = _LoadIconToBitmap(@ScriptDir & "\Buttons\Pause.ico", $iIconSizeMax)
$aGFX[8][1] = _LoadIconToBitmap(@ScriptDir & "\Buttons\Pause_a.ico", $iIconSizeMax)

_IconDock_EndUpdate($hIconDock)
GUISetState()

Global $bPause = False

While 1
	Sleep(100)
WEnd

Func _LoadIconToBitmap($sFile, $iSize)
	Local $hIcon = _WinAPI_ShellExtractIcon($sFile, 0, $iSize, $iSize)
	Local $hBitmap = _IconDock_GetBitmapFromHIcon($hIcon, $iSize, $iSize)
	_WinAPI_DestroyIcon($hIcon)
	Return $hBitmap
EndFunc   ;==>_LoadIconToBitmap


Func _ChangeIcon($hID, $iIconIndex)
	Local Static $iOldIndex = $iIconIndex
	Local $iPlus = 0
	If $iOldIndex = 4 And $bPause = True Then $iPlus = 4
	_IconDock_IconSetBitmap($hID, $iOldIndex, $aGFX[$iOldIndex + $iPlus][0])
	$iPlus = 0
	If $iIconIndex = 4 And $bPause = True Then $iPlus = 4
	_IconDock_IconSetBitmap($hID, $iIconIndex, $aGFX[$iIconIndex + $iPlus][1])
	$iOldIndex = $iIconIndex
EndFunc   ;==>_ChangeIcon


Func _EventFunction($hID, $iIconIndex, $iEventMsg)
	Switch $hID
		Case $hIconDock
			Switch $iIconIndex
				Case 1
					ConsoleWrite("! Previous" & @CRLF)
				Case 2
					ConsoleWrite("! Fast Rewind" & @CRLF)
				Case 3
					ConsoleWrite("! Stop" & @CRLF)
					$bPause = False
					_ChangeIcon($hID, 4)
					_IconDock_EndUpdate($hIconDock)
				Case 4
					Switch $bPause
						Case False
							ConsoleWrite("! Play" & @CRLF)
							$bPause = True
						Case Else
							ConsoleWrite("! Pause" & @CRLF)
							$bPause = False
					EndSwitch
					_ChangeIcon($hID, 4)
					_IconDock_EndUpdate($hIconDock)
				Case 5
					ConsoleWrite("! Fast Forward" & @CRLF)
				Case 6
					ConsoleWrite("! Next" & @CRLF)
				Case 7
					ConsoleWrite("! Record" & @CRLF)
			EndSwitch
	EndSwitch
EndFunc   ;==>_EventFunction


Func _Exit()
	_IconDock_Destroy($hIconDock)
	For $i = 1 To 8
		_GDIPlus_BitmapDispose($aGFX[$i][0])
		_GDIPlus_BitmapDispose($aGFX[$i][1])
	Next
	Exit
EndFunc   ;==>_Exit

; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_ShellExtractIcon
; Description....: Extracts the icon with the specified dimension from the specified file.
; Syntax.........: _WinAPI_ShellExtractIcon ( $sIcon, $iIndex, $iWidth, $iHeight )
; Parameters.....: $sIcon   - Path and name of the file from which the icon are to be extracted.
;                  $iIndex  - Index of the icon to extract.
;                  $iWidth  - Horizontal icon size wanted.
;                  $iHeight - Vertical icon size wanted.
; Return values..: Success  - Handle to the extracted icon.
;                  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: If the icon with the specified dimension is not found in the file, it will choose the nearest appropriate icon and
;                  change to the specified dimension. When you are finished using the icon, destroy it using the _WinAPI_DestroyIcon()
;                  function.
; Related........:
; Link...........: @@MsdnLink@@ SHExtractIcons
; Example........: Yes
; ===============================================================================================================================

Func _WinAPI_ShellExtractIcon($sIcon, $iIndex, $iWidth, $iHeight)
	Local $Ret = DllCall('shell32.dll', 'int', 'SHExtractIconsW', 'wstr', $sIcon, 'int', $iIndex, 'int', $iWidth, 'int', $iHeight, 'ptr*', 0, 'ptr*', 0, 'int', 1, 'int', 0)
	If (@error) Or (Not $Ret[0]) Or (Not $Ret[5]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[5]
EndFunc   ;==>_WinAPI_ShellExtractIcon